resource "google_compute_instance" "bastion_host" {
  name         = var.bastionhostname
  machine_type = var.bastionmachinetype
  zone         = "${var.regions[0]}-b"

  tags = var.bastiontags

  boot_disk {
    initialize_params {
      image = var.bastion_image
    }
  }

  network_interface {
    subnetwork = var.public_subnetid
    access_config {}
  }

 metadata = {
    startup-script = <<-EOT
    #!/bin/bash
      sudo apt-get update
      sudo apt-get install apt-transport-https ca-certificates gnupg curl
      curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
      echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
      sudo apt-get update && sudo apt-get install google-cloud-cli
      sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin
      sudo apt update
      sudo apt install curl -y
      sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
      sudo chmod +x kubectl
      sudo mv kubectl /usr/local/bin/
      sudo snap install helm --classic
      curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v2.7.3/argocd-linux-amd64
      chmod +x argocd-linux-amd64
      sudo mv argocd-linux-amd64 /usr/local/bin/argocd
    EOT
  }

}
