provider "google" {
  credentials = file("C:\\Users\\Sahil Koundal\\Downloads\\engaged-carving-429915-k3-50d81a7f99d8.json")
  project     = "engaged-carving-429915-k3"
  region      = "asia-south2"
  zone         = "asia-south2-b"
}
resource "google_compute_instance" "test-server" {
  name         = "terraform-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-south2-b"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "projects/centos-cloud/global/images/centos-stream-9-v20240709" # Correct image URL
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "hi" > /test.txt
  EOT

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    
    scopes = ["cloud-platform"]
}
}
