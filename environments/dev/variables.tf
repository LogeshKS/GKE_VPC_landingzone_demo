variable "env" {
  
}
variable "projectid" {
  
}


#vpc
variable "vpcname" {}
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
variable "subnet_cidr_ranges" {}


#router
variable "nat-routername" {}

#natgateway
variable "natgateway" {}


#VM
variable "bastionhostname" {}
variable "bastion_image" {}
variable "bastionmachinetype" {}

variable "bastiontags" {}

variable "gkeclustertags" {}


variable "pod_cidr_ranges" {
  
}
variable "service_cidr_ranges" {
  
}

variable "master_ipv4_cidr_block" {
  
}
