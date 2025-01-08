#vpc
variable "vpcname" {}
variable "projectid" {}
variable "routing_mode" {}
variable "mtu" {}

#public_subnet
variable "public_subnetname" {}
variable "public_subnet_cidr_range" {}


variable "regions" {
  type = list(string)
}

#gkesubnet
variable "gkeclustername" {}
variable "subnet_cidr_ranges" {
  
}


#router
variable "nat-routername" {}

#natgateway
variable "natgateway" {}

variable "pod_cidr_ranges" {
  
}

variable "service_cidr_ranges" {
  
}
