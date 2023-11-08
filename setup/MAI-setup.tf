provider "google" {
  project = "your-gcp-project-id"
  region  = "us-west2"
  zone    = "us-west2-a"
}

terraform {
  backend "gcs" {
    bucket = "your-gcs-bucket-name"
    prefix = "terraform/state"
  }
}

resource "google_compute_address" "static" {
  name = "static-ip"
}

resource "google_compute_instance" "default" {
  name         = "vm-instance"
  machine_type = "n1-standard-2" # 2 vCPUs and 7.5GB RAM. Adjust this if needed.

  boot_disk {
    initialize_params {
      image_family = "ubuntu-2004-lts"
      image_project = "ubuntu-os-cloud"
      size = "20"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata_startup_script = file("startup.sh")

  tags = ["http-server", "https-server"] # Allow HTTP & HTTPS traffic.
}

resource "google_compute_firewall" "default" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server", "https-server"]
}
