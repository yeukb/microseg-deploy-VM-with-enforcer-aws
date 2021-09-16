variable "aws_access_key" { }

variable "aws_secret_key" { }

variable "region" { }

variable "aws_ssh_key" { }

variable "AllowedSourceIPRange" { }

variable "vmName" { }

variable "vmSize" { }

variable "cns_api" { }

variable "cns_namespace" { }

variable "vpc_name" {
    default = "microseg_demo"
 }

variable "vpc_cidr" {
    default = "10.10.0.0/16"
}

variable "linux_subnet" {
    default = "10.10.10.0/24"
}

variable "linux_ip" {
    default = "10.10.10.10"
}

