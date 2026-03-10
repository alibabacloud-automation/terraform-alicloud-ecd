阿里云弹性云桌面 Terraform 模块

# terraform-alicloud-ecd

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ecd/blob/main/README.md) | 简体中文

此 Terraform 模块创建和管理阿里云 ECD（弹性云桌面）资源，为虚拟桌面基础设施提供全面的解决方案。该模块使组织能够在云中部署安全、可扩展且经济高效的虚拟桌面环境，支持远程工作场景和集中式桌面管理。

## 使用方法

此模块允许您创建完整的 ECD 环境，包括办公站点、桌面、策略组和用户管理。您可以根据需要自定义配置。

```terraform
data "alicloud_ecd_bundles" "default" {
  bundle_type = "SYSTEM"
  name_regex  = ".*Windows.*"
}

module "ecd" {
  source = "alibabacloud-automation/ecd/alicloud"

  # 简单办公站点
  simple_office_site_config = {
    cidr_block = "172.16.0.0/12"
  }

  # 策略组
  policy_group_config = {
    policy_group_name = "my-policy-group"
  }

  # 桌面
  create_desktop = true
  desktop_config = {
    desktop_name = "my-desktop-1"
    bundle_id    = data.alicloud_ecd_bundles.default.bundles[0].id
  }

  # 用户
  users_config = {
    user1 = {
      email = "user@example.com"
      phone = "18888888888"
    }
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ecd/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.140.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.140.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecd_bundle.bundle](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_bundle) | resource |
| [alicloud_ecd_command.command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_command) | resource |
| [alicloud_ecd_custom_property.custom_properties](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_custom_property) | resource |
| [alicloud_ecd_desktop.desktop](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_desktop) | resource |
| [alicloud_ecd_nas_file_system.nas_file_system](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_nas_file_system) | resource |
| [alicloud_ecd_network_package.network_package](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_network_package) | resource |
| [alicloud_ecd_policy_group.policy_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_policy_group) | resource |
| [alicloud_ecd_ram_directory.ram_directory](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_ram_directory) | resource |
| [alicloud_ecd_simple_office_site.office_site](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_simple_office_site) | resource |
| [alicloud_ecd_snapshot.snapshot](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_snapshot) | resource |
| [alicloud_ecd_user.users](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecd_user) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorize_access_policy_rules"></a> [authorize\_access\_policy\_rules](#input\_authorize\_access\_policy\_rules) | List of authorize access policy rules | <pre>list(object({<br/>    description = optional(string, null)<br/>    cidr_ip     = string<br/>  }))</pre> | `[]` | no |
| <a name="input_authorize_security_policy_rules"></a> [authorize\_security\_policy\_rules](#input\_authorize\_security\_policy\_rules) | List of authorize security policy rules | <pre>list(object({<br/>    type        = string<br/>    policy      = string<br/>    description = optional(string, null)<br/>    port_range  = string<br/>    ip_protocol = string<br/>    priority    = string<br/>    cidr_ip     = string<br/>  }))</pre> | `[]` | no |
| <a name="input_bundle_config"></a> [bundle\_config](#input\_bundle\_config) | Configuration for the bundle | <pre>object({<br/>    bundle_name                 = optional(string, null)<br/>    description                 = optional(string, null)<br/>    desktop_type                = string<br/>    image_id                    = string<br/>    root_disk_size_gib          = number<br/>    root_disk_performance_level = optional(string, "PL1")<br/>    user_disk_size_gib          = list(number)<br/>    user_disk_performance_level = optional(string, "PL1")<br/>    language                    = optional(string, "en-US")<br/>  })</pre> | <pre>{<br/>  "desktop_type": null,<br/>  "image_id": null,<br/>  "root_disk_size_gib": null,<br/>  "user_disk_size_gib": []<br/>}</pre> | no |
| <a name="input_command_config"></a> [command\_config](#input\_command\_config) | Configuration for ECD command | <pre>object({<br/>    command_content  = string<br/>    command_type     = string<br/>    timeout          = optional(number, 60)<br/>    content_encoding = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_create_bundle"></a> [create\_bundle](#input\_create\_bundle) | Whether to create a bundle | `bool` | `false` | no |
| <a name="input_create_command"></a> [create\_command](#input\_create\_command) | Whether to create a command | `bool` | `false` | no |
| <a name="input_create_desktop"></a> [create\_desktop](#input\_create\_desktop) | Whether to create a desktop | `bool` | `false` | no |
| <a name="input_create_nas_file_system"></a> [create\_nas\_file\_system](#input\_create\_nas\_file\_system) | Whether to create a NAS file system | `bool` | `false` | no |
| <a name="input_create_network_package"></a> [create\_network\_package](#input\_create\_network\_package) | Whether to create a network package | `bool` | `false` | no |
| <a name="input_create_policy_group"></a> [create\_policy\_group](#input\_create\_policy\_group) | Whether to create a policy group | `bool` | `true` | no |
| <a name="input_create_ram_directory"></a> [create\_ram\_directory](#input\_create\_ram\_directory) | Whether to create a RAM directory | `bool` | `false` | no |
| <a name="input_create_simple_office_site"></a> [create\_simple\_office\_site](#input\_create\_simple\_office\_site) | Whether to create a simple office site | `bool` | `true` | no |
| <a name="input_create_snapshot"></a> [create\_snapshot](#input\_create\_snapshot) | Whether to create a snapshot | `bool` | `false` | no |
| <a name="input_custom_properties_config"></a> [custom\_properties\_config](#input\_custom\_properties\_config) | Configuration for custom properties | <pre>map(object({<br/>    property_values = list(object({<br/>      property_value = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_desktop_config"></a> [desktop\_config](#input\_desktop\_config) | Configuration for ECD desktop | <pre>object({<br/>    desktop_name       = string<br/>    bundle_id          = optional(string, null)<br/>    amount             = optional(number, 1)<br/>    auto_pay           = optional(bool, false)<br/>    auto_renew         = optional(bool, false)<br/>    desktop_type       = optional(string, null)<br/>    end_user_ids       = optional(list(string), [])<br/>    host_name          = optional(string, null)<br/>    payment_type       = optional(string, "PayAsYouGo")<br/>    period             = optional(number, null)<br/>    period_unit        = optional(string, null)<br/>    root_disk_size_gib = optional(number, null)<br/>    status             = optional(string, null)<br/>    stopped_mode       = optional(string, null)<br/>    user_assign_mode   = optional(string, "ALL")<br/>    user_disk_size_gib = optional(number, null)<br/>    tags               = optional(map(string), {})<br/>  })</pre> | `null` | no |
| <a name="input_desktop_id"></a> [desktop\_id](#input\_desktop\_id) | ID of an existing desktop. Required when create\_desktop is false | `string` | `null` | no |
| <a name="input_nas_file_system_config"></a> [nas\_file\_system\_config](#input\_nas\_file\_system\_config) | Configuration for ECD NAS file system | <pre>object({<br/>    nas_file_system_name = string<br/>    description          = optional(string, null)<br/>    file_system_id       = optional(string, null)<br/>    mount_target_domain  = optional(string, null)<br/>    reset                = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_network_package_config"></a> [network\_package\_config](#input\_network\_package\_config) | Configuration for the network package | <pre>object({<br/>    bandwidth = optional(number, 10)<br/>  })</pre> | `{}` | no |
| <a name="input_policy_group_config"></a> [policy\_group\_config](#input\_policy\_group\_config) | Configuration for the policy group | <pre>object({<br/>    policy_group_name      = string<br/>    clipboard              = optional(string, "read")<br/>    local_drive            = optional(string, "read")<br/>    usb_redirect           = optional(string, "off")<br/>    watermark              = optional(string, "off")<br/>    watermark_transparency = optional(string, null)<br/>    watermark_type         = optional(string, null)<br/>    html_access            = optional(string, "off")<br/>    html_file_transfer     = optional(string, "off")<br/>    visual_quality         = optional(string, "medium")<br/>    recording              = optional(string, "off")<br/>    recording_start_time   = optional(string, null)<br/>    recording_end_time     = optional(string, null)<br/>    recording_fps          = optional(number, null)<br/>    recording_expires      = optional(number, null)<br/>    camera_redirect        = optional(string, "off")<br/>    domain_list            = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "policy_group_name": null<br/>}</pre> | no |
| <a name="input_policy_group_id"></a> [policy\_group\_id](#input\_policy\_group\_id) | ID of an existing policy group. Required when create\_policy\_group is false | `string` | `null` | no |
| <a name="input_ram_directory_config"></a> [ram\_directory\_config](#input\_ram\_directory\_config) | Configuration for RAM directory | <pre>object({<br/>    ram_directory_name     = string<br/>    desktop_access_type    = optional(string, "INTERNET")<br/>    enable_admin_access    = optional(bool, true)<br/>    enable_internet_access = optional(bool, null)<br/>    vswitch_ids            = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_simple_office_site_config"></a> [simple\_office\_site\_config](#input\_simple\_office\_site\_config) | Configuration for the simple office site | <pre>object({<br/>    office_site_name            = optional(string)<br/>    cidr_block                  = string<br/>    desktop_access_type         = optional(string, "Internet")<br/>    enable_admin_access         = optional(bool, true)<br/>    enable_cross_desktop_access = optional(bool, false)<br/>    mfa_enabled                 = optional(bool, false)<br/>    sso_enabled                 = optional(bool, false)<br/>    cen_id                      = optional(string)<br/>    cen_owner_id                = optional(string)<br/>  })</pre> | <pre>{<br/>  "cidr_block": null<br/>}</pre> | no |
| <a name="input_simple_office_site_id"></a> [simple\_office\_site\_id](#input\_simple\_office\_site\_id) | ID of an existing simple office site. Required when create\_simple\_office\_site is false | `string` | `null` | no |
| <a name="input_snapshot_config"></a> [snapshot\_config](#input\_snapshot\_config) | Configuration for ECD snapshot | <pre>object({<br/>    snapshot_name    = string<br/>    description      = optional(string, null)<br/>    source_disk_type = string<br/>  })</pre> | `null` | no |
| <a name="input_users_config"></a> [users\_config](#input\_users\_config) | Configuration for ECD users | <pre>map(object({<br/>    email    = string<br/>    phone    = optional(string, null)<br/>    password = optional(string, null)<br/>    status   = optional(string, "Unlocked")<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bundle_id"></a> [bundle\_id](#output\_bundle\_id) | The ID of the bundle |
| <a name="output_command_id"></a> [command\_id](#output\_command\_id) | The ID of the ECD command |
| <a name="output_command_status"></a> [command\_status](#output\_command\_status) | The status of the ECD command |
| <a name="output_current_account_id"></a> [current\_account\_id](#output\_current\_account\_id) | The current account ID |
| <a name="output_current_region_id"></a> [current\_region\_id](#output\_current\_region\_id) | The current region ID |
| <a name="output_custom_property_ids"></a> [custom\_property\_ids](#output\_custom\_property\_ids) | The IDs of the custom properties |
| <a name="output_desktop_id"></a> [desktop\_id](#output\_desktop\_id) | The ID of the desktop |
| <a name="output_desktop_status"></a> [desktop\_status](#output\_desktop\_status) | The status of the desktop |
| <a name="output_nas_file_system_id"></a> [nas\_file\_system\_id](#output\_nas\_file\_system\_id) | The ID of the NAS file system |
| <a name="output_nas_file_system_status"></a> [nas\_file\_system\_status](#output\_nas\_file\_system\_status) | The status of the NAS file system |
| <a name="output_network_package_id"></a> [network\_package\_id](#output\_network\_package\_id) | The ID of the network package |
| <a name="output_network_package_status"></a> [network\_package\_status](#output\_network\_package\_status) | The status of the network package |
| <a name="output_policy_group_id"></a> [policy\_group\_id](#output\_policy\_group\_id) | The ID of the policy group |
| <a name="output_policy_group_status"></a> [policy\_group\_status](#output\_policy\_group\_status) | The status of the policy group |
| <a name="output_ram_directory_id"></a> [ram\_directory\_id](#output\_ram\_directory\_id) | The ID of the RAM directory |
| <a name="output_ram_directory_status"></a> [ram\_directory\_status](#output\_ram\_directory\_status) | The status of the RAM directory |
| <a name="output_simple_office_site_id"></a> [simple\_office\_site\_id](#output\_simple\_office\_site\_id) | The ID of the simple office site |
| <a name="output_simple_office_site_status"></a> [simple\_office\_site\_status](#output\_simple\_office\_site\_status) | The status of the simple office site |
| <a name="output_snapshot_id"></a> [snapshot\_id](#output\_snapshot\_id) | The ID of the snapshot |
| <a name="output_snapshot_status"></a> [snapshot\_status](#output\_snapshot\_status) | The status of the snapshot |
| <a name="output_user_ids"></a> [user\_ids](#output\_user\_ids) | The IDs of the users |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)