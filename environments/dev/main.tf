#defining configurations

locals {
   env = var.env
}

#defining VPC
module "vpc" {
    source = "../../modules/vpc"

    vpcname = "${local.env}-${var.vpcname}"
    projectid = var.projectid
    routing_mode = var.routing_mode
    mtu = var.mtu

    public_subnetname = "${local.env}-${var.public_subnetname}"
    public_subnet_cidr_range = var.public_subnet_cidr_range

    subnetname = "${local.env}-${var.private_subnetname}"
    private_subnet_iprange = var.private_subnet_iprange

    gkeclustername = "${local.env}-${var.gkeclustername}"
    subnet_cidr_ranges = var.subnet_cidr_ranges
    pod_cidr_ranges = var.pod_cidr_ranges
    service_cidr_ranges = var.service_cidr_ranges
   # gke_cluster_ip_cidr = var.gke_cluster_ip_cidr    
    nat-routername = "${local.env}-${var.nat-routername}"

    natgateway = "${local.env}-${var.natgateway}"

    regions = var.regions
}

module "gke" {

    source = "../../modules/gke"

    projectid = var.projectid
    regions = var.regions
    gke_cluster_name = "${local.env}-${var.gkeclustername}"
    vpcid = module.vpc.vpcid
    master_ipv4_cidr_block = var.master_ipv4_cidr_block
    gke_cluster_subnetwork = {
    for region in var.regions : region => module.vpc.gke_cluster_subnetwork[region].name
  }
    gkeclustertags = var.gkeclustertags
}

module "vm" {

    source = "../../modules/vm"

    bastionhostname = "${local.env}-${var.bastionhostname}"
    bastionmachinetype = var.bastionmachinetype
    regions = var.regions
    public_subnetid = module.vpc.public_subnet
    bastiontags = var.bastiontags
    bastion_image = var.bastion_image
   

    jenkinsmachinetype = var.jenkinsmachinetype
    jenkinshostname = "${local.env}-${var.jenkinshostname}"
    jenkinsimage = var.jenkinsimage
    jenkinstags = var.jenkinstags

    private_subnetid = module.vpc.private_subnetid
 

    vpcid = module.vpc.vpcid
    gkeclustertags = var.gkeclustertags

  
}


