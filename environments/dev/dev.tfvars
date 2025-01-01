env = "dev"
projectid = "dulcet-glazing-444913-i8"


#vpc
vpcname = "vpc"
routing_mode = "REGIONAL"
mtu = "1500"

public_subnetname = "public-subnet"
public_subnet_cidr_range = "192.168.1.0/24"

private_subnetname = "private-subnet"
private_subnet_iprange = "192.168.2.0/24"

regions = ["us-east1","us-west2"]

#GKE

gkeclustername = "gke-cluster"

subnet_cidr_ranges = {
   "us-east1" = "172.16.0.0/20" 
   "us-west2" = "172.17.0.0/20"
}

pod_cidr_ranges = {
    "us-east1" = "172.18.0.0/20" 
    "us-west2" = "172.19.0.0/20"
}   

service_cidr_ranges ={
    "us-east1" = "172.20.0.0/20" 
    "us-west2" = "172.21.0.0/20"
}

master_ipv4_cidr_block = {
    "us-east1" = "192.168.9.0/28" 
    "us-west2" = "192.168.10.0/28"
}

#gke_cluster_ip_cidr = {
 #   "pod-ip-range"    = "192.168.5.0.0/24"
  #  "services-ip-range" = "192.168.6.0/24"
#}

#router
nat-routername = "router"

#natgateway

natgateway = "nat"

#VM

bastionhostname = "bastion-host"
bastion_image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
bastionmachinetype = "e2-micro"
bastiontags = ["bastion"]

# jenkinshostname = "jenkins-host"
# jenkinsimage = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
# jenkinsmachinetype = "e2-standard-4"
# jenkinstags = ["jenkins"]

gkeclustertags = ["gkeclusters"]








