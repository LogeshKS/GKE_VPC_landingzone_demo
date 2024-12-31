env = "dev"
projectid = "dulcet-glazing-444913-i8"
regions = [ "value" ]

#vpc
vpcname = "vpc"
routing_mode = "REGIONAL"
mtu = "1500"

public_subnetname = "public-subnet"
public_subnet_cidr_range = "192.168.1.0/24"

private_subnetname = "private-subnet"
private_subnet_iprange = "192.168.2.0/24"

regions = ["asia-south1","asia-east1"]

#GKE

gkeclustername = "dev-gke-cluster"
subnet_cidr_ranges = ["192.168.3.0/24","192.168.4.0/24"]
gke_cluster_ip_cidr = {
    "pod-ip-range"    = "192.168.5.0.0/24"
    "services-ip-range" = "192.168.6.0/24"
}

#router
nat-routername = "router"

#natgateway

natgateway = "nat"

#VM

bastionhostname = "bastion-host"
bastion_image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
bastionmachinetype = "e2.micro"
bastiontags = ["bastion"]

jenkinshostname = "jenkins-host"
jenkinsimage = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
jenkinsmachinetype = "e2-standard-4"
jenkinstags = ["jenkins"]

gkeclustertags = ["cluster1", "cluster2"]








