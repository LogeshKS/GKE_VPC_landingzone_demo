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
      sudo apt update
      sudo apt install curl -y
      sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
      sudo chmod +x kubectl
      sudo mv kubectl /usr/local/bin/
      kubectl version --client

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

