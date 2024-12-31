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


variable "bastionhostname" {}
variable "bastion_image" {}
variable "bastionmachinetype" {}
variable "private_subnetid" {}
variable "public_subnetid" {}
variable "bastiontags" {}
variable "jenkinstags" {}
variable "jenkinsmachinetype" {}
variable "jenkinsimage" {}
variable "jenkinshostname" {}
variable "vpcid" {}
variable "bastion_trustedip" {}
variable "jenkins_trustedip" {}
variable "gkeclustertags" {}

variable "gke_cluster_name" {
  
}
variable "gke_cluster_subnetwork" {
  
}
variable "gke_cluster_ipv4_cidr" {
  
}
variable "gke_services_ipv4_cidr" {
  
}