variable "region" {
  default = "europe-west2-a"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "/Users/jcn15/.config/gcloud/jc-service.json"
}

provider "google" {
  credentials = "${file("${var.credentials_file_path}")}"
  project     = "durable-cycle-211214"
  region      = "${var.region}"
}

resource "google_compute_instance" "test" {
  count        = 1
  name         = "test${count.index + 1}"
  machine_type = "f1-micro"
  zone         = "${var.region}"

  boot_disk {
    initialize_params {
      image = "centos-7-v20180716"
    }
    }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }
}
