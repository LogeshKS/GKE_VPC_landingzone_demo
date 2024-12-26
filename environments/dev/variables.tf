variable "env" {
  
}
variable "projectid" {
  
}
variable "regions" {
  
}

#vpc
variable "vpcname" {}
variable "projectid" {}
variable "routing_mode" {}
variable "mtu" {}

#public_subnet
variable "public_subnetname" {}
variable "public_subnet_cidr_range" {}

#private_subnetname
variable "private_subnetname" {}
variable "private_subnet_iprange" {}
variable "regions" {
  type = list(string)
}

#gkesubnet
variable "gkeclustername" {}
variable "subnet_cidr_ranges" {}
variable "gke_cluster_ip_cidr" {}

#router
variable "nat-routername" {}

#natgateway
variable "natgateway" {}

