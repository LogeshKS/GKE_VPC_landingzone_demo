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
      sudo wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-430.0.0-linux-x86_64.tar.gz
      sudo tar -xvf google-cloud-cli-430.0.0-linux-x86_64.tar.gz
      sudo ./google-cloud-sdk/install.sh
      echo 'export PATH=$PATH:$HOME/google-cloud-sdk/bin' >> ~/.bashrc
      source ~/.bashrc
      sudo gcloud components install gke-gcloud-auth-plugin
      export USE_GKE_GCLOUD_AUTH_PLUGIN=True
      echo 'export USE_GKE_GCLOUD_AUTH_PLUGIN=True' >> ~/.bashrc
      source ~/.bashrc
      sudo gcloud components install kubectl

    EOT
  }

}
# resource "google_compute_instance" "jenkins_server" {
#   name         = var.jenkinshostname
#   machine_type = var.jenkinsmachinetype
#   zone         = "${var.regions[0]}-b"

#   tags = var.jenkinstags

#   boot_disk {
#     initialize_params {
#       image = var.jenkinsimage
#     }
#   }

#   network_interface {
#     subnetwork = var.private_subnetid
#   }

#   metadata_startup_script = file("/home/logesh/Devops/GKE_VPC_landingzone_demo/modules/vm/jenkinsstartup.sh")
# }

