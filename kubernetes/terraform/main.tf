provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "cluster_gke" {
  source = "./modules/cluster_gke"
  zone   = "${var.zone}"
  count  = "${var.count}"
}
