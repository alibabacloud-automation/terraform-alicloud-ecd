# Configure the Alicloud Provider
provider "alicloud" {
  region = var.region
}

# Random integer for unique naming
resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# Data sources for ECD resources
data "alicloud_ecd_zones" "default" {}

data "alicloud_ecd_images" "default" {
  image_type            = "SYSTEM"
  os_type               = "Windows"
  desktop_instance_type = "eds.hf.4c8g"
}

data "alicloud_ecd_desktop_types" "default" {
  instance_type_family = "eds.hf"
  cpu_count            = 4
  memory_size          = 8192
}

# VPC resources for RAM Directory
resource "alicloud_vpc" "default" {
  vpc_name   = "${var.name_prefix}-vpc-${random_integer.default.result}"
  cidr_block = "10.0.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.0.1.0/24"
  zone_id      = data.alicloud_ecd_zones.default.ids[0]
  vswitch_name = "${var.name_prefix}-vswitch-${random_integer.default.result}"
}

# Call the ECD module
module "ecd" {
  source = "../../"

  # Simple Office Site - Create new one
  create_simple_office_site = true
  simple_office_site_config = {
    office_site_name            = "${var.name_prefix}-office-site"
    cidr_block                  = "172.16.0.0/12"
    desktop_access_type         = "Internet"
    enable_admin_access         = true
    enable_cross_desktop_access = false
    mfa_enabled                 = false
    sso_enabled                 = false
  }

  # Policy Group
  create_policy_group = true
  policy_group_config = {
    policy_group_name      = "${var.name_prefix}-policy-group"
    clipboard              = "readwrite"
    local_drive            = "readwrite"
    usb_redirect           = "on"
    watermark              = "on"
    watermark_transparency = "LIGHT"
    watermark_type         = "EndUserId"
    visual_quality         = "high"
    recording              = "alltime"
    recording_start_time   = "08:00"
    recording_end_time     = "18:00"
    recording_fps          = 15
    recording_expires      = 30
    camera_redirect        = "on"
    html_access            = "off"
    html_file_transfer     = "off"
  }

  # Authorize access policy rules
  authorize_access_policy_rules = [
    {
      description = "Allow access from office network"
      cidr_ip     = "192.168.1.0/24"
    },
    {
      description = "Allow access from VPN network"
      cidr_ip     = "10.0.0.0/16"
    }
  ]

  # Authorize security policy rules
  authorize_security_policy_rules = [
    {
      type        = "inflow"
      policy      = "accept"
      description = "Allow HTTPS traffic"
      port_range  = "443/443"
      ip_protocol = "TCP"
      priority    = "1"
      cidr_ip     = "0.0.0.0/0"
    },
    {
      type        = "inflow"
      policy      = "accept"
      description = "Allow RDP traffic from office"
      port_range  = "3389/3389"
      ip_protocol = "TCP"
      priority    = "2"
      cidr_ip     = "192.168.1.0/24"
    },
    {
      type        = "outflow"
      policy      = "accept"
      description = "Allow all outbound traffic"
      port_range  = "1/65535"
      ip_protocol = "TCP"
      priority    = "1"
      cidr_ip     = "0.0.0.0/0"
    }
  ]

  # Network Package
  create_network_package = true
  network_package_config = {
    bandwidth = 10
  }

  # Custom Bundle
  create_bundle = true
  bundle_config = {
    bundle_name                 = "${var.name_prefix}-bundle"
    description                 = "Custom bundle created by Terraform"
    desktop_type                = data.alicloud_ecd_desktop_types.default.ids[0]
    image_id                    = data.alicloud_ecd_images.default.ids[0]
    root_disk_size_gib          = 80
    root_disk_performance_level = "PL1"
    user_disk_size_gib          = [70]
    user_disk_performance_level = "PL1"
    language                    = "zh-CN"
  }

  # Desktop
  create_desktop = true
  desktop_config = {
    desktop_name       = "${var.name_prefix}-desktop"
    bundle_id          = null
    amount             = 1
    auto_pay           = true
    auto_renew         = false
    desktop_type       = null
    end_user_ids       = ["developer1"]
    host_name          = "desktop-1"
    payment_type       = "PayAsYouGo"
    period             = null
    period_unit        = null
    root_disk_size_gib = null
    status             = "Running"
    stopped_mode       = "StopCharging"
    user_assign_mode   = "PER_USER"
    user_disk_size_gib = null
    tags = {
      Environment = "Test"
      Department  = "Engineering"
    }
  }

  # Users
  users_config = {
    developer1 = {
      email    = "developer1@example.com"
      phone    = "13800138001"
      password = "Dev@Password123"
      status   = "Unlocked"
    }
  }

  # Custom Properties
  custom_properties_config = {
    Department = {
      property_values = [
        { property_value = "Engineering" },
        { property_value = "Design" },
        { property_value = "Marketing" }
      ]
    }
    Location = {
      property_values = [
        { property_value = "Beijing" },
        { property_value = "Shanghai" },
        { property_value = "Hangzhou" }
      ]
    }
  }

  # Command
  create_command = true # Temporarily disable due to CloudAssistant readiness issue
  command_config = {
    command_content = "ipconfig /all"
    command_type    = "RunPowerShellScript"
    timeout         = 60
  }

  # Snapshot
  create_snapshot = true
  snapshot_config = {
    snapshot_name    = "${var.name_prefix}-snapshot"
    description      = "System disk snapshot"
    source_disk_type = "SYSTEM"
  }

  # NAS File System
  create_nas_file_system = true
  nas_file_system_config = {
    nas_file_system_name = "${var.name_prefix}-nas"
    description          = "Shared-storage-for-desktop"
    file_system_id       = null
    mount_target_domain  = null
    reset                = false
  }

  # RAM Directory
  create_ram_directory = true
  ram_directory_config = {
    ram_directory_name  = "${var.name_prefix}-ram-dir-${random_integer.default.result}"
    desktop_access_type = "INTERNET"
    enable_admin_access = true
    vswitch_ids         = [alicloud_vswitch.default.id]
  }
}
