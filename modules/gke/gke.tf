# GKE Cluster Configuration (multi-region)
resource "google_container_cluster" "gke_cluster" {
  #count        = length(var.regions)
  for_each = var.master_ipv4_cidr_block
  #name         = "${var.gke_cluster_name}-${var.regions[count.index]}"
  name = "${var.gke_cluster_name}-${each.key}"
  #location     = var.regions[count.index]
  location = each.key
  project      = var.projectid
  initial_node_count = 1
  min_master_version = "latest"
  deletion_protection = "false"
  # Network settings
  networking_mode = "VPC_NATIVE"
  network    = var.vpcid
  #subnetwork = var.gke_cluster_subnetwork[count.index]
  subnetwork = var.gke_cluster_subnetwork[each.key]
  
  # Enable private cluster configuration
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = true
    master_ipv4_cidr_block = each.value
  }

  # IP Allocation Policy
  ip_allocation_policy {
    
    cluster_secondary_range_name  = "pod-range-${each.key}"
    services_secondary_range_name = "service-range-${each.key}"
  }

  master_authorized_networks_config {
    
    cidr_blocks {
      cidr_block = "172.16.0.0/20"  # You can replace this with your specific authorized IPs
      display_name = "cluster1ip"
    }
    cidr_blocks {
      cidr_block = "172.17.0.0/20"
      display_name = "cluster2ip"
    }
  
    
  }
  
}

# GKE Node Pool Configuration
resource "google_container_node_pool" "node_pool" {
  #count       = length(var.regions)
  for_each = toset(var.regions)
  #name        = "default-node-pool-${var.regions[count.index]}"
  name        = "default-node-pool-${each.key}"
  cluster     = google_container_cluster.gke_cluster[each.key].name
  #cluster     = google_container_cluster.gke_cluster[count.index].name
  #location    = var.regions[count.index]
  location = each.key

  # Node pool configuration
  node_count  = 1
  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50
    preemptible  = true
    tags = var.gkeclustertags
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # Autoscaling for node pool
  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  depends_on = [google_container_cluster.gke_cluster]
}


