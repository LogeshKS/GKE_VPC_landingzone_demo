#firewall to allow ssh to bastion from trsuted ip
resource "google_compute_firewall" "allow_ssh_bastion" {
    name = "allow-ssh-bastion"
    network = var.vpcid

    allow {
      protocol = "tcp"
      ports = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = var.bastiontags


}


resource "google_compute_firewall" "allow_bastion_to_gke" {
  name    = "allow-bastion-to-gke"
  network = var.vpcid

  allow {
    protocol = "tcp"
    ports    = ["22"] # Kubernetes API server
  }

  source_ranges = [google_compute_instance.bastion_host.network_interface[0].access_config[0].nat_ip]
  target_tags = var.gkeclustertags

  depends_on = [ google_compute_instance.bastion_host ]
}


resource "google_compute_firewall" "allow_bastion_to_gke_api" {
  name    = "allow-bastion-to-gke-api"
  network = var.vpcid
 
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = [google_compute_instance.bastion_host.network_interface[0].access_config[0].nat_ip]

  target_tags = var.gkeclustertags 
  depends_on = [ google_compute_instance.bastion_host ]
}

resource "google_compute_firewall" "allow_bastion_to_gke_node_ports" {
  name    = "allow-bastion-to-gke-node-ports"
  network = "default"

  
  allow {
    protocol = "tcp"
    ports    = ["10250", "443"]  # Kubelet and Kubernetes API
  }

  source_ranges = [google_compute_instance.bastion_host.network_interface[0].access_config[0].nat_ip]  # Replace with your Bastion host's external IP

  target_tags = var.gkeclustertags  # Add this tag to your GKE worker nodes

  depends_on = [ google_compute_instance.bastion_host ]
}
