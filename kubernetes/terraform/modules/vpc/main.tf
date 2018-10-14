resource "google_compute_network" "kubernetes-the-hard-way" {
  name                    = "kubernetes-the-hard-way"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kubernetes" {
  name          = "kubernetes"
  ip_cidr_range = "10.240.0.0/24"
  region        = "${var.region}"
  network       = "${google_compute_network.kubernetes-the-hard-way.self_link}"
}

resource "google_compute_firewall" "kubernetes-the-hard-way-allow-internal" {
  name    = "kubernetes-the-hard-way-allow-internal"
  network = "kubernetes-the-hard-way"

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.240.0.0/24", "10.200.0.0/16"]
}

resource "google_compute_firewall" "kubernetes-the-hard-way-allow-external" {
  name    = "kubernetes-the-hard-way-allow-external"
  network = "kubernetes-the-hard-way"

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "kubernetes-the-hard-way-external-ip" {
  name         = "kubernetes-external-ip"
  address_type = "EXTERNAL"
  region       = "${var.region}"
}

resource "google_compute_http_health_check" "kubernetes-the-hard-way-health-check" {
  name         = "kubernetes-the-hard-way-health-check"
  request_path = "/healthz"

  timeout_sec        = 1
  check_interval_sec = 1
}

resource "google_compute_firewall" "kubernetes-the-hard-way-allow-health-check" {
  name    = "kubernetes-the-hard-way-allow-health-check"
  network = "kubernetes-the-hard-way"

  allow {
    protocol = "tcp"
  }

  source_ranges = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
}

resource "google_compute_target_pool" "kubernetes-the-hard-way-target-pool" {
  name = "kubernetes-the-hard-way-target-pool"

  instances = [
    "${var.zone}/controller-0",
    "${var.zone}/controller-1",
    "${var.zone}/controller-2",
  ]

  health_checks = [
    "${google_compute_http_health_check.kubernetes-the-hard-way-health-check.name}",
  ]
}

resource "google_compute_forwarding_rule" "kubernetes-the-hard-way-forwarding-rule" {
  name       = "kubernetes-the-hard-way-forwarding-rule"
  ip_address = "${google_compute_address.kubernetes-the-hard-way-external-ip.self_link}"
  target     = "${google_compute_target_pool.kubernetes-the-hard-way-target-pool.self_link}"
  port_range = "6443"
}
