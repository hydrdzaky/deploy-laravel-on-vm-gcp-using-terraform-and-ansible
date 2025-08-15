resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = "vpc-kly"
  auto_create_subnetworks = true
  mtu                     = 1460
}
resource "google_compute_subnetwork" "subnet_network" {
  name          = "kly-subnet"
  ip_cidr_range = "10.10.10.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}
resource "google_compute_firewall" "rules" {
  project       = var.project_id
  name          = "allow-port"
  network       = google_compute_network.vpc_network.name
  description   = "Allow incoming traffic for Dependencies"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["8000", "5173"]
  }
  target_tags = ["allow-port"]
}

resource "google_compute_firewall" "allow-http" {
  project       = var.project_id
  name          = "allow-http"
  network       = google_compute_network.vpc_network.name
  description   = "Allow incoming HTTP traffic on port 80"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["allow-http"]
}

resource "google_compute_firewall" "allow-https" {
  project       = var.project_id
  name          = "allow-https"
  network       = google_compute_network.vpc_network.name
  description   = "Allow incoming HTTPS traffic on port 443"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["allow-https"]
}

resource "google_compute_firewall" "allow-ssh" {
  project       = var.project_id
  name          = "allow-ssh"
  network       = google_compute_network.vpc_network.name
  description   = "Allow incoming ssh traffic on port 443"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["allow-ssh"]
}