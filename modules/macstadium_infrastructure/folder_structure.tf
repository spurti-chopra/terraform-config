resource "vsphere_folder" "base_vms" {
  path       = "Base VMs"
  datacenter_id = "${var.datacenter}"
  type = "vm"
}

resource "vsphere_folder" "build_vms" {
  path       = "Build VMs"
  datacenter_id = "${var.datacenter}"
  type = "vm"
}

resource "vsphere_folder" "internal_vms" {
  path       = "Internal VMs"
  datacenter_id = "${var.datacenter}"
  type = "vm"
}

resource "vsphere_folder" "vanilla_vms" {
  path       = "Vanilla VMs"
  datacenter_id = "${var.datacenter}"
  type = "vm"
}
