variable "region" {
  description = "The region where to deploy the ECD resources"
  type        = string
  default     = "cn-hangzhou"
}

variable "name_prefix" {
  description = "Name prefix for all resources"
  type        = string
  default     = "ecd-example"
}

