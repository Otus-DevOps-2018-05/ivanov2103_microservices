resource "google_compute_instance" "k8s-controller" {
  name           = "controller-${count.index}"
  machine_type   = "n1-standard-1"
  can_ip_forward = true
  zone           = "${var.zone}"
  tags           = ["kubernetes-the-hard-way", "controller"]
  count          = "${var.count}"

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
      size  = "200"
    }
  }

  network_interface {
    address       = "10.240.0.1${count.index}"
    subnetwork    = "kubernetes"
    access_config = {}
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}
