variable "region" {
  description = "AWS region"
  type        = string
}
variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}
variable "lb_prefix" { type = string }
variable "target_port" { type = number }
variable "health_check_path" { type = string }
variable "target_ip" {type = string}
