#!/usr/bin/env bash
set -o errexit
set -o pipefail

main() {
  local post_sleep="${POST_SHUTDOWN_SLEEP}"
  local max_err="${MAX_ERROR_COUNT}"
  local run_d="${RUNDIR}"
  local error_count
  : "${post_sleep:=300}"
  : "${max_err:=9}"
  : "${run_d:=/var/tmp/travis-run.d}"

  if [[ -f "${run_d}/implode.confirm" ]]; then
    __handle_implode_confirm "${run_d}" "${post_sleep}"
  fi

  error_count="$(
    "${DMESG:-dmesg}" \
      | grep -c 'unregister_netdevice: waiting for lo to become free'
  )"

  if [[ "${error_count}" -gt "${max_err}" ]]; then
    __handle_exceeded_max_unregister_netdevice "${run_d}" "${error_count}"
  fi
}

__handle_implode_confirm() {
  local run_d="${1}"
  local post_sleep="${2}"

  local reason
  reason="$(cat "${run_d}/implode.confirm" 2>/dev/null)"
  : "${reason:=not sure why}"
  "${SHUTDOWN:-/sbin/shutdown}" -P now "imploding because ${reason}"
  sleep "${POST_SHUTDOWN_SLEEP}"
  exit 0
}

__handle_exceeded_max_unregister_netdevice() {
  local run_d="${1}"
  local error_count="${2}"

  echo "detected unregister_netdevice via dmesg count=${error_count}" \
    | tee "${run_d}/implode"
  "${DOCKER:-docker}" kill -s INT travis-worker
}

main "$@"
