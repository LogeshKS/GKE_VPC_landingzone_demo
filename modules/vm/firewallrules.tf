#firewall to allow ssh to bastion from trsuted ip
resource "google_compute_firewall" "allow_ssh_bastion" {
    name = "allow-ssh-bastion"
    network = var.vpcid

    allow {
      protocol = "tcp"
      ports = ["22"]
    }

    source_ranges = [var.bastion_trustedip]# Replace with your trusted IP
    target_tags = [var.bastiontags]

}

#firewall to allow http to jenkins from trusted ip
resource "google_compute_firewall" "allow_http_jenkins" {
    name = "allow-http-jenkins"
    network = var.vpcid

    allow {
      protocol = "tcp"
      ports = ["8080", "9090"]
    }

    source_ranges = [var.jenkins_trustedip]
    target_tags = [var.jenkinstags]
}

# Allow GKE bastion to access GKE API

resource "google_compute_firewall" "allow_bastion_jenkins_to_gke" {
  name    = "allow-bastion-jenkins-to-gke"
  network = var.vpcid

  allow {
    protocol = "tcp"
    ports    = ["443"] # Kubernetes API server
  }

  source_tags = [var.bastiontags]
  target_tags = [var.gkeclustertags]
}


