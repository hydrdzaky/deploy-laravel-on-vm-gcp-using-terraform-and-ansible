# Launch a VM on it
resource "google_compute_instance" "vm-instance" {
  name         = "vm-kly"
  project      = var.project_id
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250709"
      size  = 20
    }
  }

  network_interface {
    subnetwork         = google_compute_subnetwork.subnet_network.name
    subnetwork_project = var.project_id

    access_config {
  nat_ip = "34.128.91.21"
    }
  }

  # Apply the firewall rule to allow external IPs to ping this instance
  tags = ["allow-port", "allow-http", "allow-https", "allow-ssh"]


  metadata = {
    ssh-keys       = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
    startup-script = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y ansible
    EOF
  }
}