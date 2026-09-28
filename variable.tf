variable "environment" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "instance_count" {
  type = number
}
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}