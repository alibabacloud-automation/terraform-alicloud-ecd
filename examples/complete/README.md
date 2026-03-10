# Complete ECD Example

This example demonstrates a comprehensive deployment of Alibaba Cloud Elastic Cloud Desktop (ECD) with ALL available resources and advanced configurations.

## Features Demonstrated

This complete example showcases ALL ECD resources:

1. **Simple Office Site**
   - Dedicated workspace for ECD
   - Internet or VPC access type
   - Admin access and cross-desktop access control

2. **Policy Group Configuration**
   - Advanced clipboard and local drive permissions (readwrite)
   - USB redirection enabled
   - Watermark configuration with custom transparency
   - Screen recording with scheduled time windows
   - Camera redirection enabled
   - HTML5 access with file transfer
   - Access and security policy rules

3. **Network Package**
   - Internet bandwidth allocation
   - Configurable bandwidth (10 Mbps default)

4. **Custom Bundle**
   - Custom desktop template
   - Configurable CPU, memory, and disk
   - Windows or Linux OS support
   - System and data disk performance levels

5. **Virtual Desktops**
   - Multiple desktop instances
   - User assignment (per-user or shared)
   - PayAsYouGo or Subscription payment
   - Configurable tags and properties

6. **User Management**
   - Multiple ECD end users
   - Email and phone contact info
   - Password and status management

7. **Custom Properties**
   - Department, Location, Project attributes
   - Flexible property values
   - Desktop classification

8. **ECS Commands & Invocations**
   - PowerShell or Shell scripts
   - Execute commands on desktops
   - Configurable timeout and working directory

9. **Custom Images**
   - Create images from desktops
   - Reusable desktop templates

10. **Snapshots**
    - System and data disk snapshots
    - Backup and recovery

11. **NAS File System**
    - Shared storage for desktops
    - Network file access

12. **RAM Directory** (Optional)
    - VPC-based directory service
    - Enterprise AD integration

## Prerequisites

- Terraform >= 1.0
- Alibaba Cloud account with appropriate permissions
- An existing ECD office site (optional, can be created)
- Random provider for unique resource naming

## Usage

This example uses feature flags to control which resources are created. You can enable/disable each resource type independently.

### Quick Start (Minimal Resources)

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Apply with default settings (creates only users and custom properties):
   ```bash
   terraform apply
   ```

### Full Deployment (All Resources)

1. Create a `terraform.tfvars` file:
   ```hcl
   region = "cn-hangzhou"
   name_prefix = "my-ecd"

   # Enable all resources
   create_simple_office_site = true
   create_network_package = true
   create_bundle = true
   create_desktops = true
   create_users = true
   create_custom_properties = true
   create_commands = true
   create_snapshots = true
   create_nas_file_system = true
   create_ram_directory = true

   # Network configuration
   office_network_cidr = "192.168.1.0/24"
   vpn_network_cidr = "10.0.0.0/16"
   datacenter_cidr = "172.16.0.0/16"

   # User configuration
   test_user_email = "test@yourcompany.com"
   test_user_phone = "13800000000"

   # Tags
   common_tags = {
     Environment = "production"
     Project = "cloud-desktop"
     Owner = "devops-team"
   }
   ```

2. Apply the configuration:
   ```bash
   terraform apply
   ```

### Step-by-Step Deployment

For production deployments, it's recommended to create resources in stages:

**Stage 1: Foundation** (Office Site, Policy Group, Users)
```hcl
create_simple_office_site = true
create_users = true
create_custom_properties = true
```

**Stage 2: Networking** (Network Package, NAS)
```hcl
create_network_package = true
create_nas_file_system = true
```

**Stage 3: Desktops** (Bundle, Desktops)
```hcl
create_bundle = true
create_desktops = true
```

**Stage 4: Operations** (Commands, Snapshots)
```hcl
create_commands = true
create_snapshots = true
```

**Stage 5: Images** (After stopping desktops)
- Manually stop desktops in Alibaba Cloud Console
- Uncomment the `images_config` section in main.tf
- Set `create_images = true`
- Run `terraform apply`

## Configuration Details

### Policy Group

The policy group is configured with enhanced security and monitoring features:

- **Clipboard**: readwrite - Users can copy/paste in both directions
- **Local Drive**: readwrite - Full access to local drives
- **USB Redirection**: on - USB devices can be used in virtual desktops
- **Watermark**: on - Desktop sessions show user ID and hostname
- **Recording**: on - Sessions recorded from 08:00 to 18:00
- **Camera**: on - Camera devices can be accessed
- **HTML Access**: on - HTML5 client access enabled
- **Domain Whitelist**: Access restricted to *.example.com and *.test.com

### Security Rules

#### Access Policy Rules
1. Office network (192.168.1.0/24)
2. VPN network (10.0.0.0/16)
3. Datacenter network (172.16.0.0/16)

#### Security Policy Rules (Inbound)
1. HTTPS (443) - Global access
2. RDP (3389) - Office network only
3. SSH (22) - Office network only
4. HTTP (80) - Global access

#### Security Policy Rules (Outbound)
1. All TCP traffic (1-65535) - Global access

### Users

Five test users are created with different roles:

| User ID     | Email                     | Phone       | Role        |
|-------------|---------------------------|-------------|-------------|
| developer1  | developer1@example.com    | 13800138001 | Developer   |
| developer2  | developer2@example.com    | 13800138002 | Developer   |
| designer1   | designer1@example.com     | 13800138003 | Designer    |
| manager1    | manager1@example.com      | 13800138004 | Manager     |
| testuser1   | (configurable)            | (configurable) | Test User   |

### Custom Properties

Three custom property dimensions are defined:

1. **Department**: Engineering, Design, Management, Marketing
2. **Location**: Beijing, Shanghai, Hangzhou, Shenzhen
3. **Project**: ProjectA, ProjectB, ProjectC

## Resource Creation Order

Due to dependencies between resources, they must be created in this order:

```
1. Simple Office Site (or use existing)
   ↓
2. Policy Group
   ↓
3. Network Package (depends on Office Site)
   ↓
4. Bundle (optional, or use system bundle)
   ↓
5. Users (can be created anytime)
   ↓
6. Custom Properties (can be created anytime)
   ↓
7. Desktops (depends on Office Site, Policy Group, Bundle, Users)
   ↓
8. Commands (depends on Desktops being Running)
   ↓
9. Snapshots (depends on Desktops being Running)
   ↓
10. NAS File System (depends on Office Site)
    ↓
11. Images (depends on Desktops being Stopped)
```

## Outputs

This example provides the following outputs:

- `simple_office_site_id` - Office site identifier
- `policy_group_id` - Policy group identifier
- `network_package_id` - Network package identifier
- `bundle_id` - Custom bundle identifier
- `desktop_ids` - Map of desktop identifiers
- `user_ids` - Map of user identifiers
- `custom_property_ids` - Map of custom property identifiers
- `invocation_ids` - Map of command invocation identifiers
- `invocation_statuses` - Map of command invocation statuses
- `image_ids` - Map of image identifiers
- `snapshot_ids` - Map of snapshot identifiers
- `nas_file_system_ids` - Map of NAS file system identifiers
- `ram_directory_id` - RAM directory identifier
- `ram_directory_status` - RAM directory status
- `vpc_id` - VPC identifier (for RAM directory)
- `vswitch_id` - vSwitch identifier (for RAM directory)
- `current_region_id` - Current region identifier

## Feature Flags

| Variable | Default | Description |
|----------|---------|-------------|
| `create_simple_office_site` | `false` | Create new office site (uses existing by default) |
| `create_network_package` | `false` | Create network package for internet access |
| `create_bundle` | `false` | Create custom desktop bundle |
| `create_desktops` | `false` | Create virtual desktop instances |
| `create_users` | `true` | Create ECD end users |
| `create_custom_properties` | `true` | Create custom property definitions |
| `create_commands` | `false` | Execute commands on desktops |
| `create_images` | `false` | Create custom images from desktops |
| `create_snapshots` | `false` | Create disk snapshots |
| `create_nas_file_system` | `false` | Create shared NAS storage |
| `create_ram_directory` | `false` | Create RAM directory with VPC |

## Important Notes

1. **Office Site**: By default uses an existing office site (`create_simple_office_site = false`). Set to `true` to create a new one.

2. **Desktop Creation**: Requires office site, policy group, and bundle. Desktops will be in `Running` status by default.

3. **Commands**: Can only be executed on Running desktops. Ensure desktops are created and running first.

4. **Images**: Can only be created from Stopped desktops. You must manually stop desktops before creating images.

5. **Snapshots**: Can be created from Running desktops. Both system and data disk snapshots are supported.

6. **RAM Directory**: Creates a VPC and vSwitch. Only enable if you need enterprise AD integration.

7. **Cost Considerations**:
   - Running desktops incur hourly charges
   - Network packages have bandwidth costs
   - Snapshots and images consume storage
   - Review pricing before enabling all resources

8. **Quota Limitations**:
   - Office sites may have regional quotas
   - Network packages are limited per office site
   - Check your account quotas before deployment

9. **Security**: The example security rules are for demonstration. Restrict access in production based on your requirements.

10. **ECS Commands**: This example uses the new `alicloud_ecs_command` and `alicloud_ecs_invocation` resources instead of the deprecated `alicloud_ecd_command` resource.

## Cleanup

To destroy all resources created by this example:

```bash
terraform destroy
```

## Support

For issues and questions:
- Module Issues: [GitHub Issues](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecd/issues)
- Alibaba Cloud ECD Documentation: [Official Docs](https://www.alibabacloud.com/help/elastic-desktop-service)
