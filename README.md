# AWS ELB Terraform 

Terraform module, which creates ELB resources along with Security Groups for secure HTTPS access on AWS.

These types of resources are supported:

* [ELB](https://www.terraform.io/docs/providers/aws/r/elb.html)
* [Security Group](https://www.terraform.io/docs/providers/aws/r/security_group.html)

#### The following resources will be configured:

*  **ELB security group** with unrestricted access allowed to port 443 (HTTPS) and all egress port protocol and ports allowed.
*  **Application security group** with access from the ELB security group on port 8080 along with all egress port protocol and ports allowed.
*  **ELB** with access logs shipping enabled with 5 minutes interval, Health check configured to `/health` every 10s with 3s Healthy/Unhealthy threshold and 2s timeout. Also, request listener configured with SSL certificate

## Note

* Valid SSL certificate arn has to be specified as `ssl_certificate_id` argument in `elb_listener_ssl` variable for ELB listener.
* S3 bucket used to collect the ELB logs needs proper IAM Policy attached to it to be able to ship the logs.


## Terraform versions

Terraform 0.12

## Provision Instructions

**Initialize a working directory containing Terraform configuration files**
```
terraform init
```
**Create an execution plan**
```
terraform plan
```
**Create Resources**
```
terraform apply
```
**Delete Resources**
```
terraform destroy
```
## Inputs

| Name                        | Description                                 | Type                                                                                                                                |
|-----------------------------|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| region                      | AWS Region                                  | string                                                                                                                              |
| vpc_id                      | VPC ID                                      | string                                                                                                                              |
| elb_name                    | The name of the ELB                         | string                                                                                                                              |
| elb_subnets                 | A list of subnet IDs to attach to the ELB   | list(string)                                                                                                                        |
| elb_access_logs             | Access Log S3 details for ELB logs shipping | object({ bucket = string, bucket_prefix = string, interval = number })                                                              |
| elb_listener_ssl            | SSL Request Listener for the ELB            | object({ instance_port = number, instance_protocol = string, lb_port = number, lb_protocol = string, ssl_certificate_id = string }) |
| elb_health_check            | Target health check for ELB                 | object({ healthy_threshold = number, unhealthy_threshold = number, timeout = number, interval = number, target = string })          |
| elb_sg_name                 | ELB security group name                     | string                                                                                                                              |
| elb_sg_description          | ELB security group description              | string                                                                                                                              |
| elb_sg_ingress_rules        | ELB security group ingress rules            | object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string) })                                     |
| elb_target_sg_name          | ELB targets security group name             | string                                                                                                                              |
| elb_target_sg_description   | ELB targets security group description      | string                                                                                                                              |
| elb_target_sg_ingress_rules | ELB targets security group ingress rules    | object({ from_port = number, to_port = number, protocol = string })                                                                 |
