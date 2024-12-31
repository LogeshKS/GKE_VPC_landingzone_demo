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

module "gke" {

    source = "../../modules/gke"

    projectid = var.projectid
    regions = var.regions
    gke_cluster_name = "${local.env}-${var.gke_cluster_name}"
    vpcid = module.vpc.vpcid
    gke_cluster_subnetwork = var.gke_cluster_subnetwork
    gke_cluster_ipv4_cidr = var.gke_cluster_ip_cidr
    gke_services_ipv4_cidr = var.gke_services_ipv4_cidr
  
}

module "vm" {

    source = "../../modules/vm"

    bastionhostname = "${local.env}-${var.bastionhostname}"
    bastionmachinetype = var.bastionmachinetype
    regions = var.regions
    public_subnetid = var.public_subnetid
    bastiontags = "${local.env}-${var.bastiontags}"
    bastion_image = var.bastion_image
    bastion_trustedip = var.bastion_trustedip

    jenkinsmachinetype = var.jenkinsmachinetype
    jenkinshostname = "${local.env}-${var.jenkinshostname}"
    jenkinsimage = var.jenkinsimage
    jenkinstags = "${local.env}-${var.jenkinstags}"

    private_subnetid = var.private_subnetid
    jenkins_trustedip = var.jenkins_trustedip

    vpcid = module.vpc.vpcid
    gkeclustertags = module.gke.tags

  
}


