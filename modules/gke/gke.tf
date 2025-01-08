# GKE Cluster Configuration (multi-region)
resource "google_container_cluster" "gke_cluster" {
  
  for_each = var.master_ipv4_cidr_block  
  name = "${var.gke_cluster_name}-${each.key}"
  
  location = each.key
  project      = var.projectid
  remove_default_node_pool = true 
  initial_node_count = 1
  min_master_version = "latest"
  deletion_protection = "false"

  # Network settings
  networking_mode = "VPC_NATIVE"
  network    = var.vpcid
  
  subnetwork = var.gke_cluster_subnetwork[each.key]

  
  enable_multi_networking = true
   
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
      cidr_block = var.bastionip
      display_name = var.display_name

    }
  
    
  }
  
}

# GKE Node Pool Configuration
resource "google_container_node_pool" "node_pool" {
 
  for_each = toset(var.regions)
  
  name        = "dev-node-pool-${each.key}"
  cluster     = google_container_cluster.gke_cluster[each.key].name
  location = each.key

  # Node pool configuration
  node_count  = 1
  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50
    preemptible  = false
    tags = var.gkeclustertags
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # Autoscaling for node pool
  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  depends_on = [google_container_cluster.gke_cluster]
}


