output "vpcid" {
  value = google_compute_network.mainvpc.id
}

output "private_subnetid"{
    value = google_compute_subnetwork.private_subnet.id
}

output "public_subnet" {
    value = google_compute_subnetwork.public_subnet.id
}

output "gke_cluster_subnetwork" {
    value = google_compute_subnetwork.gke_cluster_subnetwork.id
}
