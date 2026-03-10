# Get current region information
data "alicloud_regions" "current" {
  current = true
}

# Get current account information
data "alicloud_account" "current" {}

# Local variables for complex logic
locals {
  # Computed resource IDs based on create flags
  office_site_id  = var.create_simple_office_site ? alicloud_ecd_simple_office_site.office_site[0].id : var.simple_office_site_id
  policy_group_id = var.create_policy_group ? alicloud_ecd_policy_group.policy_group[0].id : var.policy_group_id
  bundle_id       = var.create_bundle ? alicloud_ecd_bundle.bundle[0].id : var.desktop_config.bundle_id
  desktop_id      = var.create_desktop ? alicloud_ecd_desktop.desktop[0].id : var.desktop_id
}

# Simple Office Site - Main workspace for ECD
resource "alicloud_ecd_simple_office_site" "office_site" {
  count = var.create_simple_office_site ? 1 : 0

  office_site_name            = var.simple_office_site_config.office_site_name
  cidr_block                  = var.simple_office_site_config.cidr_block
  desktop_access_type         = var.simple_office_site_config.desktop_access_type
  enable_admin_access         = var.simple_office_site_config.enable_admin_access
  enable_cross_desktop_access = var.simple_office_site_config.enable_cross_desktop_access
  mfa_enabled                 = var.simple_office_site_config.mfa_enabled
  sso_enabled                 = var.simple_office_site_config.sso_enabled
  cen_id                      = var.simple_office_site_config.cen_id
  cen_owner_id                = var.simple_office_site_config.cen_owner_id
}

# Network Package - Internet bandwidth for office site
resource "alicloud_ecd_network_package" "network_package" {
  count = var.create_network_package ? 1 : 0

  office_site_id = local.office_site_id
  bandwidth      = var.network_package_config.bandwidth
}

# NAS File System - Shared storage for desktop
resource "alicloud_ecd_nas_file_system" "nas_file_system" {
  count = var.create_nas_file_system ? 1 : 0

  nas_file_system_name = var.nas_file_system_config.nas_file_system_name
  office_site_id       = local.office_site_id
  description          = var.nas_file_system_config.description
  file_system_id       = var.nas_file_system_config.file_system_id
  mount_target_domain  = var.nas_file_system_config.mount_target_domain
  reset                = var.nas_file_system_config.reset
}

# Policy Group - Security and access policies for desktops
resource "alicloud_ecd_policy_group" "policy_group" {
  count = var.create_policy_group ? 1 : 0

  policy_group_name      = var.policy_group_config.policy_group_name
  clipboard              = var.policy_group_config.clipboard
  local_drive            = var.policy_group_config.local_drive
  usb_redirect           = var.policy_group_config.usb_redirect
  watermark              = var.policy_group_config.watermark
  watermark_transparency = var.policy_group_config.watermark_transparency
  watermark_type         = var.policy_group_config.watermark_type
  html_access            = var.policy_group_config.html_access
  html_file_transfer     = var.policy_group_config.html_file_transfer
  visual_quality         = var.policy_group_config.visual_quality
  recording              = var.policy_group_config.recording
  recording_start_time   = var.policy_group_config.recording_start_time
  recording_end_time     = var.policy_group_config.recording_end_time
  recording_fps          = var.policy_group_config.recording_fps
  recording_expires      = var.policy_group_config.recording_expires
  camera_redirect        = var.policy_group_config.camera_redirect
  domain_list            = var.policy_group_config.domain_list

  # Dynamic authorize access policy rules
  dynamic "authorize_access_policy_rules" {
    for_each = var.authorize_access_policy_rules
    content {
      description = authorize_access_policy_rules.value.description
      cidr_ip     = authorize_access_policy_rules.value.cidr_ip
    }
  }

  # Dynamic authorize security policy rules
  dynamic "authorize_security_policy_rules" {
    for_each = var.authorize_security_policy_rules
    content {
      type        = authorize_security_policy_rules.value.type
      policy      = authorize_security_policy_rules.value.policy
      description = authorize_security_policy_rules.value.description
      port_range  = authorize_security_policy_rules.value.port_range
      ip_protocol = authorize_security_policy_rules.value.ip_protocol
      priority    = authorize_security_policy_rules.value.priority
      cidr_ip     = authorize_security_policy_rules.value.cidr_ip
    }
  }
}

# Bundle - Desktop template configuration
resource "alicloud_ecd_bundle" "bundle" {
  count = var.create_bundle ? 1 : 0

  bundle_name                 = var.bundle_config.bundle_name
  description                 = var.bundle_config.description
  desktop_type                = var.bundle_config.desktop_type
  image_id                    = var.bundle_config.image_id
  root_disk_size_gib          = var.bundle_config.root_disk_size_gib
  root_disk_performance_level = var.bundle_config.root_disk_performance_level
  user_disk_size_gib          = var.bundle_config.user_disk_size_gib
  user_disk_performance_level = var.bundle_config.user_disk_performance_level
  language                    = var.bundle_config.language
}

# Desktops - Virtual desktop instance
resource "alicloud_ecd_desktop" "desktop" {
  count = var.create_desktop ? 1 : 0

  desktop_name       = var.desktop_config.desktop_name
  office_site_id     = local.office_site_id
  policy_group_id    = local.policy_group_id
  bundle_id          = local.bundle_id
  amount             = var.desktop_config.amount
  auto_pay           = var.desktop_config.auto_pay
  auto_renew         = var.desktop_config.auto_renew
  desktop_type       = var.desktop_config.desktop_type
  end_user_ids       = var.desktop_config.end_user_ids
  host_name          = var.desktop_config.host_name
  payment_type       = var.desktop_config.payment_type
  period             = var.desktop_config.period
  period_unit        = var.desktop_config.period_unit
  root_disk_size_gib = var.desktop_config.root_disk_size_gib
  status             = var.desktop_config.status
  stopped_mode       = var.desktop_config.stopped_mode
  user_assign_mode   = var.desktop_config.user_assign_mode
  user_disk_size_gib = var.desktop_config.user_disk_size_gib
  tags               = var.desktop_config.tags
}

# Snapshots - Desktop snapshot for backup
resource "alicloud_ecd_snapshot" "snapshot" {
  count = var.create_snapshot ? 1 : 0

  snapshot_name    = var.snapshot_config.snapshot_name
  desktop_id       = local.desktop_id
  description      = var.snapshot_config.description
  source_disk_type = var.snapshot_config.source_disk_type
}

# ECD Command - Execute command on desktop
resource "alicloud_ecd_command" "command" {
  count = var.create_command ? 1 : 0

  command_content  = var.command_config.command_content
  command_type     = var.command_config.command_type
  desktop_id       = local.desktop_id
  timeout          = var.command_config.timeout
  content_encoding = var.command_config.content_encoding
}

# Users - ECD end users
resource "alicloud_ecd_user" "users" {
  for_each = var.users_config

  end_user_id = each.key
  email       = each.value.email
  phone       = each.value.phone
  password    = each.value.password
  status      = each.value.status
}

# Custom Properties - Custom attributes for desktops
resource "alicloud_ecd_custom_property" "custom_properties" {
  for_each = var.custom_properties_config

  property_key = each.key

  dynamic "property_values" {
    for_each = each.value.property_values
    content {
      property_value = property_values.value.property_value
    }
  }
}

# RAM Directory - Enterprise directory service
resource "alicloud_ecd_ram_directory" "ram_directory" {
  count = var.create_ram_directory ? 1 : 0

  ram_directory_name     = var.ram_directory_config.ram_directory_name
  desktop_access_type    = var.ram_directory_config.desktop_access_type
  enable_admin_access    = var.ram_directory_config.enable_admin_access
  enable_internet_access = var.ram_directory_config.enable_internet_access
  vswitch_ids            = var.ram_directory_config.vswitch_ids
}
