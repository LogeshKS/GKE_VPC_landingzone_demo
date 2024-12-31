#firewall to allow ssh to bastion from trsuted ip
resource "google_compute_firewall" "allow_ssh_bastion" {
    name = "allow-ssh-bastion"
    network = var.vpcid

    allow {
      protocol = "tcp"
      ports = ["22"]
    }

    source_ranges = [google_compute_instance.bastion_host.network_interface[0].access_config[0].nat_ip]
    target_tags = var.bastiontags

depends_on = [ google_compute_instance.bastion_host ]

}

#firewall to allow http to jenkins from trusted ip
resource "google_compute_firewall" "allow_http_jenkins" {
    name = "allow-http-jenkins"
    network = var.vpcid

    allow {
      protocol = "tcp"
      ports = ["8080", "9090"]
    }

    source_ranges = [google_compute_instance.jenkins_server.network_interface[0].network_ip]
    target_tags = var.jenkinstags

  depends_on = [ google_compute_instance.jenkins_server ]
}

# Allow GKE bastion to access GKE API

resource "google_compute_firewall" "allow_bastion_jenkins_to_gke" {
  name    = "allow-bastion-jenkins-to-gke"
  network = var.vpcid

  allow {
    protocol = "tcp"
    ports    = ["443"] # Kubernetes API server
  }

  source_tags = var.bastiontags
  target_tags = var.gkeclustertags
}


