variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
}

variable zone {
  description = "Instance resource zone"
  default     = "europe-west1-b"
}

variable count {
  description = "Number of instances"
  default     = "2"
}
