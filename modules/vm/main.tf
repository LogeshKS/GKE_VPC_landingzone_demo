data "local_file" "bastion_script" {
  filename = "/home/logesh/Devops/GKE_VPC_landingzone_demo/environments/dev/bastionscript.sh"
}

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
    startup-script = "data.local_file.bastion_script.content"
  }

}
