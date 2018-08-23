provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "docker" {
  source           = "./modules/docker"
  public_key_path  = "${var.public_key_path}"
  zone             = "${var.zone}"
  disk_image       = "${var.disk_image}"
  count            = "${var.count}"
}

