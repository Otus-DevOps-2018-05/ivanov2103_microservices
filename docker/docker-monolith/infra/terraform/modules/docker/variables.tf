variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "Instance resource zone"
  default     = "europe-west1-b"
}

variable disk_image {
  description = "Disk image"
  default     = "my-docker-hosts"
}

variable count {
  description = "Number of instances"
  default     = "1"
}

