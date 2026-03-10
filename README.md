Alicloud ECD (Elastic Cloud Desktop) Terraform Module

# terraform-alicloud-ecd

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-ecd/blob/main/README-CN.md)

This Terraform module creates and manages Alibaba Cloud ECD (Elastic Cloud Desktop) resources, providing a comprehensive solution for virtual desktop infrastructure. The module enables organizations to deploy secure, scalable, and cost-effective virtual desktop environments in the cloud, supporting remote work scenarios and centralized desktop management. For more information about ECD solutions, see [Elastic Cloud Desktop](https://www.alibabacloud.com/product/elastic-cloud-desktop).

## Usage

This module allows you to create a complete ECD environment including office sites, desktops, policy groups, and user management. You can customize the configuration based on your requirements.

```terraform
data "alicloud_ecd_bundles" "default" {
  bundle_type = "SYSTEM"
  name_regex  = ".*Windows.*"
}

module "ecd" {
  source = "alibabacloud-automation/ecd/alicloud"
  
  # Common configuration
  name_prefix = "my-ecd"
  common_tags = {
    Environment = "production"
    Project     = "virtual-desktop"
  }

  # Simple Office Site configuration
  create_simple_office_site = true
  simple_office_site_config = {
    cidr_block          = "172.16.0.0/12"
    desktop_access_type = "Internet"
    enable_admin_access = true
  }

  # Policy Group configuration
  create_policy_group = true
  policy_group_config = {
    policy_group_name = "my-policy-group"
    clipboard         = "read"
    local_drive       = "read"
    usb_redirect      = "off"
    watermark         = "off"
  }

  # Desktop configuration
  desktops_config = {
    desktop1 = {
      desktop_name = "my-desktop-1"
      bundle_id    = data.alicloud_ecd_bundles.default.bundles[0].id
      payment_type = "PayAsYouGo"
    }
  }

  # User configuration
  users_config = {
    user1 = {
      email = "user@example.com"
      phone = "18888888888"
    }
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ecd/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)