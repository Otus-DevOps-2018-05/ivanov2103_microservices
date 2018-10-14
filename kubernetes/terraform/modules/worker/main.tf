resource "google_compute_instance" "k8s-worker" {
  name           = "worker-${count.index}"
  machine_type   = "n1-standard-1"
  can_ip_forward = true
  zone           = "${var.zone}"
  tags           = ["kubernetes-the-hard-way", "worker"]
  count          = "${var.count}"

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
      size  = "200"
    }
  }

  network_interface {
    address       = "10.240.0.2${count.index}"
    subnetwork    = "kubernetes"
    access_config = {}
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
    pod-cidr = "10.200.${count.index}.0/24"
  }
}

resource "google_compute_route" "kubernetes-route" {
  name        = "kubernetes-route-10-200-${count.index}-0-24"
  dest_range  = "10.200.${count.index}.0/24"
  network     = "kubernetes-the-hard-way"
  next_hop_ip = "10.240.0.2${count.index}"
  priority  = 100
  count          = "${var.count}"
  depends_on = ["google_compute_instance.k8s-worker"]
}

