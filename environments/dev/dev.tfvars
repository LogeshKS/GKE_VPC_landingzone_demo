env = "dev"
projectid = "dulcet-glazing-444913-i8"


#vpc
vpcname = "vpc"
routing_mode = "REGIONAL"
mtu = "1500"

public_subnetname = "public-subnet"
public_subnet_cidr_range = "192.168.0.0/28"


regions = ["us-east1","us-west2"]

#GKE

gkeclustername = "gke-cluster"

subnet_cidr_ranges = {
   "us-east1" = "10.0.0.0/24" 
   "us-west2" = "10.0.1.0/24"
}

pod_cidr_ranges = {
    "us-east1" = "192.169.0.0/20" 
    "us-west2" = "192.170.0.0/20"
}   

service_cidr_ranges ={
    "us-east1" = "172.16.0.0/22" 
    "us-west2" = "172.17.0.0/22"
}

master_ipv4_cidr_block = {
    "us-east1" = "192.168.9.0/28" 
    "us-west2" = "192.168.10.0/28"
}

#router
nat-routername = "router"

#natgateway

natgateway = "nat"

#VM

bastionhostname = "bastion-host"
bastion_image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
bastionmachinetype = "e2-micro"
bastiontags = ["bastion"]


gkeclustertags = ["gkeclusters"]








