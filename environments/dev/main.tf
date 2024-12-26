#defining configurations

locals {
   env = var.env
}

#defining VPC
module "vpc" {
    source = "../../modules/vpc"

    vpcname = "${local.env}"
    projectid = var.projectid
    routing_mode = var.routing_mode
    mtu = var.mtu

    public_subnetname = var.public_subnetname
    public_subnet_cidr_range = var.public_subnet_cidr_range

    subnetname = var.private_subnetname
    private_subnet_iprange = var.private_subnet_iprange

    gkeclustername = "${local.env}-${var.gkeclustername}-${var.regions}"
    subnet_cidr_ranges = var.subnet_cidr_ranges

    gke_cluster_ip_cidr = var.gke_cluster_ip_cidr
    
    nat-routername = "${local.env}-${var.nat-routername}"

    natgateway = "${local.env}-${var.natgateway}"

    regions = var.regions
}

