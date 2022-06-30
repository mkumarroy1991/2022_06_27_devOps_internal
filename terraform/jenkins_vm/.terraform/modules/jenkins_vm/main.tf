
resource "google_compute_instance" "jenkins" {
  name = "jenkins-terraform"
  machine_type = "e2-small"

  boot_disk {
    initialize_params {
      image = "projects/jenkins-base/global/images/jenkins-image-3"
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  tags = ["allow-my-http"]

  metadata_startup_script = "docker pull google/cloud-sdk:latest"
}