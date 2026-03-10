

# Simple Office Site configuration
variable "create_simple_office_site" {
  description = "Whether to create a simple office site"
  type        = bool
  default     = true
}

variable "simple_office_site_id" {
  description = "ID of an existing simple office site. Required when create_simple_office_site is false"
  type        = string
  default     = null
}

variable "simple_office_site_config" {
  description = "Configuration for the simple office site"
  type = object({
    office_site_name            = optional(string)
    cidr_block                  = string
    desktop_access_type         = optional(string, "Internet")
    enable_admin_access         = optional(bool, true)
    enable_cross_desktop_access = optional(bool, false)
    mfa_enabled                 = optional(bool, false)
    sso_enabled                 = optional(bool, false)
    cen_id                      = optional(string)
    cen_owner_id                = optional(string)
  })
  default = {
    cidr_block = null
  }
}

# Policy Group configuration
variable "create_policy_group" {
  description = "Whether to create a policy group"
  type        = bool
  default     = true
}

variable "policy_group_id" {
  description = "ID of an existing policy group. Required when create_policy_group is false"
  type        = string
  default     = null
}

variable "policy_group_config" {
  description = "Configuration for the policy group"
  type = object({
    policy_group_name      = string
    clipboard              = optional(string, "read")
    local_drive            = optional(string, "read")
    usb_redirect           = optional(string, "off")
    watermark              = optional(string, "off")
    watermark_transparency = optional(string, null)
    watermark_type         = optional(string, null)
    html_access            = optional(string, "off")
    html_file_transfer     = optional(string, "off")
    visual_quality         = optional(string, "medium")
    recording              = optional(string, "off")
    recording_start_time   = optional(string, null)
    recording_end_time     = optional(string, null)
    recording_fps          = optional(number, null)
    recording_expires      = optional(number, null)
    camera_redirect        = optional(string, "off")
    domain_list            = optional(string, null)
  })
  default = {
    policy_group_name = null
  }
}

variable "authorize_access_policy_rules" {
  description = "List of authorize access policy rules"
  type = list(object({
    description = optional(string, null)
    cidr_ip     = string
  }))
  default = []
}

variable "authorize_security_policy_rules" {
  description = "List of authorize security policy rules"
  type = list(object({
    type        = string
    policy      = string
    description = optional(string, null)
    port_range  = string
    ip_protocol = string
    priority    = string
    cidr_ip     = string
  }))
  default = []
}

# Network Package configuration
variable "create_network_package" {
  description = "Whether to create a network package"
  type        = bool
  default     = false
}

variable "network_package_config" {
  description = "Configuration for the network package"
  type = object({
    bandwidth = optional(number, 10)
  })
  default = {}
}

# Bundle configuration
variable "create_bundle" {
  description = "Whether to create a bundle"
  type        = bool
  default     = false
}

variable "bundle_config" {
  description = "Configuration for the bundle"
  type = object({
    bundle_name                 = optional(string, null)
    description                 = optional(string, null)
    desktop_type                = string
    image_id                    = string
    root_disk_size_gib          = number
    root_disk_performance_level = optional(string, "PL1")
    user_disk_size_gib          = list(number)
    user_disk_performance_level = optional(string, "PL1")
    language                    = optional(string, "en-US")
  })
  default = {
    desktop_type       = null
    image_id           = null
    root_disk_size_gib = null
    user_disk_size_gib = []
  }
}

# Desktop configuration
variable "create_desktop" {
  description = "Whether to create a desktop"
  type        = bool
  default     = false
}

variable "desktop_id" {
  description = "ID of an existing desktop. Required when create_desktop is false"
  type        = string
  default     = null
}

variable "desktop_config" {
  description = "Configuration for ECD desktop"
  type = object({
    desktop_name       = string
    bundle_id          = optional(string, null)
    amount             = optional(number, 1)
    auto_pay           = optional(bool, false)
    auto_renew         = optional(bool, false)
    desktop_type       = optional(string, null)
    end_user_ids       = optional(list(string), [])
    host_name          = optional(string, null)
    payment_type       = optional(string, "PayAsYouGo")
    period             = optional(number, null)
    period_unit        = optional(string, null)
    root_disk_size_gib = optional(number, null)
    status             = optional(string, null)
    stopped_mode       = optional(string, null)
    user_assign_mode   = optional(string, "ALL")
    user_disk_size_gib = optional(number, null)
    tags               = optional(map(string), {})
  })
  default = null
}

# Users configuration
variable "users_config" {
  description = "Configuration for ECD users"
  type = map(object({
    email    = string
    phone    = optional(string, null)
    password = optional(string, null)
    status   = optional(string, "Unlocked")
  }))
  default = {}
}

# Custom Properties configuration
variable "custom_properties_config" {
  description = "Configuration for custom properties"
  type = map(object({
    property_values = list(object({
      property_value = string
    }))
  }))
  default = {}
}

# Snapshots configuration
variable "create_snapshot" {
  description = "Whether to create a snapshot"
  type        = bool
  default     = false
}

variable "snapshot_config" {
  description = "Configuration for ECD snapshot"
  type = object({
    snapshot_name    = string
    description      = optional(string, null)
    source_disk_type = string
  })
  default = null
}

# Commands configuration
variable "create_command" {
  description = "Whether to create a command"
  type        = bool
  default     = false
}

variable "command_config" {
  description = "Configuration for ECD command"
  type = object({
    command_content  = string
    command_type     = string
    timeout          = optional(number, 60)
    content_encoding = optional(string, null)
  })
  default = null
}


# NAS File System configuration
variable "create_nas_file_system" {
  description = "Whether to create a NAS file system"
  type        = bool
  default     = false
}

variable "nas_file_system_config" {
  description = "Configuration for ECD NAS file system"
  type = object({
    nas_file_system_name = string
    description          = optional(string, null)
    file_system_id       = optional(string, null)
    mount_target_domain  = optional(string, null)
    reset                = optional(bool, false)
  })
  default = null
}

# RAM Directory configuration
variable "create_ram_directory" {
  description = "Whether to create a RAM directory"
  type        = bool
  default     = false
}

variable "ram_directory_config" {
  description = "Configuration for RAM directory"
  type = object({
    ram_directory_name     = string
    desktop_access_type    = optional(string, "INTERNET")
    enable_admin_access    = optional(bool, true)
    enable_internet_access = optional(bool, null)
    vswitch_ids            = list(string)
  })
  default = null
}