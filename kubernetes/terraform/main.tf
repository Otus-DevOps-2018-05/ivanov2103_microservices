provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "vpc" {
  source = "./modules/vpc"
  zone   = "${var.zone}"
  region = "${var.region}"
}

module "controller" {
  source          = "./modules/controller"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  disk_image      = "${var.disk_image}"
  count           = "${var.count}"
}

module "worker" {
  source          = "./modules/worker"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  disk_image      = "${var.disk_image}"
  count           = "${var.count}"
}
