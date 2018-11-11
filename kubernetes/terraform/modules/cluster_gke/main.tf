resource "google_container_cluster" "standard-cluster-1" {
  name = "standard-cluster-1"
  zone = "${var.zone}"

  # min_master_version     = "1.8.10-gke.0"
    # Error 400: Master version "1.8.10-gke.0" is unsupported.
  initial_node_count = "${var.count}"
  enable_legacy_abac = "false"

  master_auth {
    username = ""
    password = ""
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    kubernetes_dashboard {
      disabled = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    disk_size_gb = "20"
    machine_type = "g1-small"
  }
}

resource "google_compute_firewall" "default-k8s-cluster" {
  name    = "default-k8s-cluster"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}

