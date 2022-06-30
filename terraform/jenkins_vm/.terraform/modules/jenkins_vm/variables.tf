variable "project_id" {
  description = "Your GCP Project ID."
  type        = string
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "zone" {
  type = string
  default = "us-central1-a"
}

variable "ip_address" {
    type = string
    description = "Your ip4 address"
}


