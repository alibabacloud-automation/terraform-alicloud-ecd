output "simple_office_site_id" {
  description = "The ID of the simple office site"
  value       = module.ecd.simple_office_site_id
}

output "policy_group_id" {
  description = "The ID of the policy group"
  value       = module.ecd.policy_group_id
}

output "network_package_id" {
  description = "The ID of the network package"
  value       = module.ecd.network_package_id
}

output "desktop_id" {
  description = "The ID of the desktop"
  value       = module.ecd.desktop_id
}

output "user_ids" {
  description = "The IDs of the users"
  value       = module.ecd.user_ids
}

output "current_region_id" {
  description = "The current region ID"
  value       = module.ecd.current_region_id
}

output "bundle_id" {
  description = "The ID of the bundle"
  value       = module.ecd.bundle_id
}

output "custom_property_ids" {
  description = "The IDs of the custom properties"
  value       = module.ecd.custom_property_ids
}

output "snapshot_id" {
  description = "The ID of the snapshot"
  value       = module.ecd.snapshot_id
}

output "command_id" {
  description = "The ID of the ECD command"
  value       = module.ecd.command_id
}

output "command_status" {
  description = "The status of the ECD command"
  value       = module.ecd.command_status
}

output "nas_file_system_id" {
  description = "The ID of the NAS file system"
  value       = module.ecd.nas_file_system_id
}

# RAM Directory outputs (from module)
output "ram_directory_id" {
  description = "The ID of the RAM directory"
  value       = module.ecd.ram_directory_id
}

output "ram_directory_status" {
  description = "The status of the RAM directory"
  value       = module.ecd.ram_directory_status
}

# VPC outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.default.id
}

output "vswitch_id" {
  description = "The ID of the vSwitch"
  value       = alicloud_vswitch.default.id
}

