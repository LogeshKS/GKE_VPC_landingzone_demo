# GKE Cluster Configuration (multi-region)
resource "google_container_cluster" "gke_cluster" {
  count        = length(var.regions)
  name         = "${var.gke_cluster_name}-${var.regions[count.index]}"
  location     = var.regions[count.index]
  project      = var.projectid
  initial_node_count = 1
  min_master_version = "latest"
  
  
  # Network settings
  networking_mode = "VPC_NATIVE"
  network    = var.vpcid
  subnetwork = var.gke_cluster_subnetwork[count.index]
  
  # Enable private cluster configuration
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = true
  }

  # IP Allocation Policy
  ip_allocation_policy {
    
    cluster_secondary_range_name  = "pod-ip-range"
    services_secondary_range_name = "services-ip-range"
  }
}

# GKE Node Pool Configuration
resource "google_container_node_pool" "node_pool" {
  count       = length(var.regions)
  name        = "default-node-pool-${var.regions[count.index]}"
  cluster     = google_container_cluster.gke_cluster[count.index].name
  location    = var.regions[count.index]

  # Node pool configuration
  node_count  = 1
  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 100
    preemptible  = true

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
