阿里云弹性云桌面 Terraform 模块

# terraform-alicloud-ecd

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ecd/blob/main/README.md) | 简体中文

此 Terraform 模块创建和管理阿里云 ECD（弹性云桌面）资源，为虚拟桌面基础设施提供全面的解决方案。该模块使组织能够在云中部署安全、可扩展且经济高效的虚拟桌面环境，支持远程工作场景和集中式桌面管理。有关 ECD 解决方案的更多信息，请参阅[弹性云桌面](https://www.alibabacloud.com/product/elastic-cloud-desktop)。

## 使用方法

此模块允许您创建完整的 ECD 环境，包括办公站点、桌面、策略组和用户管理。您可以根据需要自定义配置。

```terraform
data "alicloud_ecd_bundles" "default" {
  bundle_type = "SYSTEM"
  name_regex  = ".*Windows.*"
}

module "ecd" {
  source = "alibabacloud-automation/ecd/alicloud"
  
  # 通用配置
  name_prefix = "my-ecd"
  common_tags = {
    Environment = "production"
    Project     = "virtual-desktop"
  }

  # 简单办公站点配置
  create_simple_office_site = true
  simple_office_site_config = {
    cidr_block          = "172.16.0.0/12"
    desktop_access_type = "Internet"
    enable_admin_access = true
  }

  # 策略组配置
  create_policy_group = true
  policy_group_config = {
    policy_group_name = "my-policy-group"
    clipboard         = "read"
    local_drive       = "read"
    usb_redirect      = "off"
    watermark         = "off"
  }

  # 桌面配置
  desktops_config = {
    desktop1 = {
      desktop_name = "my-desktop-1"
      bundle_id    = data.alicloud_ecd_bundles.default.bundles[0].id
      payment_type = "PayAsYouGo"
    }
  }

  # 用户配置
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