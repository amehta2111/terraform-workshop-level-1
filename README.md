<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.50 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.62.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.Demo-ASG-tf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_db_instance.rds-instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.rds_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_eip.eip_natgw1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.eip_natgw2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.terraform-workshop-vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_configuration.webserver-launch-config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_lb.ALB-tf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.front_end](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.TG-tf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_nat_gateway.natgateway_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.natgateway_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.prv_sub1_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.prv_sub2_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.pub_sub1_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.internet_for_pub_sub1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.internet_for_pub_sub2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.pri_sub1_to_natgw1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.pri_sub2_to_natgw1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_secretsmanager_secret.secretmasterDB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.sversion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.elb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.rds-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.webserver_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.prv_sub1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.prv_sub2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.pub_sub1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.pub_sub2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [random_string.password](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [aws_secretsmanager_secret.secretmasterDB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | n/a | `string` | `"ami-07d3a50bd29811cd1"` | no |
| <a name="input_keyname"></a> [keyname](#input\_keyname) | n/a | `string` | `"terraform-workshop-vm"` | no |
| <a name="input_prv_sub1_cidr_block"></a> [prv\_sub1\_cidr\_block](#input\_prv\_sub1\_cidr\_block) | n/a | `string` | `"172.16.3.0/24"` | no |
| <a name="input_prv_sub2_cidr_block"></a> [prv\_sub2\_cidr\_block](#input\_prv\_sub2\_cidr\_block) | n/a | `string` | `"172.16.4.0/24"` | no |
| <a name="input_pub_sub1_cidr_block"></a> [pub\_sub1\_cidr\_block](#input\_pub\_sub1\_cidr\_block) | n/a | `string` | `"172.16.1.0/24"` | no |
| <a name="input_pub_sub2_cidr_block"></a> [pub\_sub2\_cidr\_block](#input\_pub\_sub2\_cidr\_block) | n/a | `string` | `"172.16.2.0/24"` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | n/a | `bool` | `false` | no |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | n/a | `number` | `10` | no |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | n/a | `string` | `"postgres"` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | n/a | `string` | `"12.10"` | no |
| <a name="input_rds_identifier"></a> [rds\_identifier](#input\_rds\_identifier) | n/a | `string` | `"postgres"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | n/a | `string` | `"db.t3.micro"` | no |
| <a name="input_rds_name"></a> [rds\_name](#input\_rds\_name) | n/a | `string` | `"postgrestholevel"` | no |
| <a name="input_rds_port"></a> [rds\_port](#input\_rds\_port) | n/a | `number` | `5432` | no |
| <a name="input_rds_storage_encrypted"></a> [rds\_storage\_encrypted](#input\_rds\_storage\_encrypted) | n/a | `bool` | `true` | no |
| <a name="input_rds_storage_type"></a> [rds\_storage\_type](#input\_rds\_storage\_type) | n/a | `string` | `"gp2"` | no |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | n/a | `string` | `"postgres"` | no |
| <a name="input_region"></a> [region](#input\_region) | default region | `string` | `"ap-south-1"` | no |
| <a name="input_resource_tag_name"></a> [resource\_tag\_name](#input\_resource\_tag\_name) | n/a | `string` | `"rds-tho-test"` | no |
| <a name="input_sg_description"></a> [sg\_description](#input\_sg\_description) | n/a | `string` | `"SG for application load balancer"` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | n/a | `string` | `"alb_sg_tho_level_1"` | no |
| <a name="input_sg_tagname"></a> [sg\_tagname](#input\_sg\_tagname) | n/a | `string` | `"SG for ALB"` | no |
| <a name="input_sg_ws_description"></a> [sg\_ws\_description](#input\_sg\_ws\_description) | n/a | `string` | `"SG for web server"` | no |
| <a name="input_sg_ws_name"></a> [sg\_ws\_name](#input\_sg\_ws\_name) | n/a | `string` | `"webserver_sg_tho_level1"` | no |
| <a name="input_sg_ws_tagname"></a> [sg\_ws\_tagname](#input\_sg\_ws\_tagname) | n/a | `string` | `"SG for web"` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | default vpc\_cidr\_block | `string` | `"172.16.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The dns name of alb |
| <a name="output_rds_password"></a> [rds\_password](#output\_rds\_password) | The database password |
<!-- END_TF_DOCS -->