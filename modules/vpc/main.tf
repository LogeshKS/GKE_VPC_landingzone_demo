#creating a VPC

resource "google_compute_network" "mainvpc" {

    name = var.vpcname
    project = var.projectid
    auto_create_subnetworks = "false"
    routing_mode = var.routing_mode
    mtu = var.mtu  
}

resource "google_compute_subnetwork" "public_subnet" {
    name = var.public_subnetname
    ip_cidr_range = var.public_subnet_cidr_range
    region = var.regions[0]
    network = google_compute_network.mainvpc.id
    private_ip_google_access = false

    depends_on = [ google_compute_network.mainvpc ]
}

# resource "google_compute_subnetwork" "private_subnet" {
    
#     name = var.subnetname
#     ip_cidr_range = var.private_subnet_iprange
#     region = var.regions[0]
#     network = google_compute_network.mainvpc.id
#     private_ip_google_access =  true

#     depends_on = [ google_compute_network.mainvpc ]

# }

resource "google_compute_subnetwork" "gke_cluster_subnetwork" {
     #count = length(var.regions)
     for_each = var.subnet_cidr_ranges
     #name    = "${var.gkeclustername}-${var.regions[count.index]}"
     name = "${var.gkeclustername}-${each.key}-subnet"
     #ip_cidr_range = var.subnet_cidr_ranges[count.index]
     #ip_cidr_range = var.subnet_cidr_ranges[each.index] 
     ip_cidr_range = each.value
     #region  = var.regions[count.index]
     region = each.key
     network = google_compute_network.mainvpc.id
     private_ip_google_access = true

    secondary_ip_range {
        range_name    = "pod-range-${each.key}"
        ip_cidr_range = var.pod_cidr_ranges[each.key]
    }

    secondary_ip_range {
        range_name    = "service-range-${each.key}"
        ip_cidr_range = var.service_cidr_ranges[each.key]
    }

  #   dynamic "secondary_ip_range" {
  #      for_each = var.gke_cluster_ip_cidr
  #      content {
  #        range_name = each.key
  #        ip_cidr_range = each.value
  #      }
  #   }
     
    depends_on = [ google_compute_network.mainvpc ]
}

#router configuration
resource "google_compute_router" "nat_router" {
    count = length(var.regions)
    name = "${var.nat-routername}-${var.regions[count.index]}"
    region = var.regions[count.index]
    network = google_compute_network.mainvpc.id

    depends_on = [ google_compute_network.mainvpc ]
}

#nat gateway
resource "google_compute_router_nat" "natgateway" {
    count = length(var.regions)
    name = "${var.natgateway}-${var.regions[count.index]}"
    router = google_compute_router.nat_router[count.index].name
    region = var.regions[count.index]
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

    depends_on = [ google_compute_router.nat_router ]

}


