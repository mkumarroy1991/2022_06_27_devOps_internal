resource "google_compute_firewall" "default" {
  name    = "jenkins-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [
    "${trim(var.ip_address, " ")}/32"
  ]
  target_tags = ["allow-my-http"] 


}