resource "google_compute_instance" "docker" {
  name         = "my-docker-hosts${count.index}"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"
  tags         = ["my-docker-hosts"]
  count        = "${var.count}"

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["my-docker-hosts"]
}
