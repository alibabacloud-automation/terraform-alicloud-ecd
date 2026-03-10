# Simple Office Site outputs
output "simple_office_site_id" {
  description = "The ID of the simple office site"
  value       = var.create_simple_office_site ? alicloud_ecd_simple_office_site.office_site[0].id : null
}

output "simple_office_site_status" {
  description = "The status of the simple office site"
  value       = var.create_simple_office_site ? alicloud_ecd_simple_office_site.office_site[0].status : null
}

# Policy Group outputs
output "policy_group_id" {
  description = "The ID of the policy group"
  value       = var.create_policy_group ? alicloud_ecd_policy_group.policy_group[0].id : null
}

output "policy_group_status" {
  description = "The status of the policy group"
  value       = var.create_policy_group ? alicloud_ecd_policy_group.policy_group[0].status : null
}

# Network Package outputs
output "network_package_id" {
  description = "The ID of the network package"
  value       = var.create_network_package ? alicloud_ecd_network_package.network_package[0].id : null
}

output "network_package_status" {
  description = "The status of the network package"
  value       = var.create_network_package ? alicloud_ecd_network_package.network_package[0].status : null
}

# Bundle outputs
output "bundle_id" {
  description = "The ID of the bundle"
  value       = var.create_bundle ? alicloud_ecd_bundle.bundle[0].id : null
}

# Desktop outputs
output "desktop_id" {
  description = "The ID of the desktop"
  value       = var.create_desktop ? alicloud_ecd_desktop.desktop[0].id : null
}

output "desktop_status" {
  description = "The status of the desktop"
  value       = var.create_desktop ? alicloud_ecd_desktop.desktop[0].status : null
}

# User outputs
output "user_ids" {
  description = "The IDs of the users"
  value       = { for k, v in alicloud_ecd_user.users : k => v.id }
}

# Custom Property outputs
output "custom_property_ids" {
  description = "The IDs of the custom properties"
  value       = { for k, v in alicloud_ecd_custom_property.custom_properties : k => v.id }
}

# Snapshot outputs
output "snapshot_id" {
  description = "The ID of the snapshot"
  value       = var.create_snapshot ? alicloud_ecd_snapshot.snapshot[0].id : null
}

output "snapshot_status" {
  description = "The status of the snapshot"
  value       = var.create_snapshot ? alicloud_ecd_snapshot.snapshot[0].status : null
}

# Command outputs
output "command_id" {
  description = "The ID of the ECD command"
  value       = var.create_command ? alicloud_ecd_command.command[0].id : null
}

output "command_status" {
  description = "The status of the ECD command"
  value       = var.create_command ? alicloud_ecd_command.command[0].status : null
}

# NAS File System outputs
output "nas_file_system_id" {
  description = "The ID of the NAS file system"
  value       = var.create_nas_file_system ? alicloud_ecd_nas_file_system.nas_file_system[0].id : null
}

output "nas_file_system_status" {
  description = "The status of the NAS file system"
  value       = var.create_nas_file_system ? alicloud_ecd_nas_file_system.nas_file_system[0].status : null
}

# RAM Directory outputs
output "ram_directory_id" {
  description = "The ID of the RAM directory"
  value       = var.create_ram_directory ? alicloud_ecd_ram_directory.ram_directory[0].id : null
}

output "ram_directory_status" {
  description = "The status of the RAM directory"
  value       = var.create_ram_directory ? alicloud_ecd_ram_directory.ram_directory[0].status : null
}

# Common outputs
output "current_region_id" {
  description = "The current region ID"
  value       = data.alicloud_regions.current.regions[0].id
}

output "current_account_id" {
  description = "The current account ID"
  value       = data.alicloud_account.current.id
}