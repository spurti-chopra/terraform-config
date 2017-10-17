resource "vsphere_folder" "base_vms" {
  path       = "VMs and Templates/Base VMs"
  datacenter_id = "${var.datacenter}"
  type = "vm"
}

resource "vsphere_folder" "build_vms" {
  path       = "VMs and Templates/Build VMs"
  datacenter_id = "${var.datacenter}"
  type = "vm"
}

resource "vsphere_folder" "internal_vms" {
  path       = "VMs and Templates/Internal VMs"
  datacenter_id = "${var.datacenter}"
  type = "vm"
}

resource "vsphere_folder" "vanilla_vms" {
  path       = "VMs and Templates/Vanilla VMs"
  datacenter_id = "${var.datacenter}"
  type = "vm"
} 
