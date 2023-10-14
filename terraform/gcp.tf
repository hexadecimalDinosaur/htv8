terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "4.51.0"
        }
    }
    required_version = "1.6.1"
}

provider "google" {
    project = "{{ gcp_project_id }}"
    region = "{{ gcp_region }}"
    zone = "{{ gcp_zone }}"
}

resource "google_compute_network" "project_vpc" {
    name = "{{ project_name}-vpc"
}

resource "google_compute_subnetwork" "project_priv_subnet" {
    network = google_compute_network.project_vpc
    name = "{{ project_name }}-priv-subnet"
    ip_cidr_range = "10.0.1.1/24"
}

resource "google_compute_subnetwork" "project_pub_subnet" {
  network = google_compute_network.project_vpc
  name = "{{ project_name }}-pub-subnet"
  ip_cidr_range = "10.0.2.1/24"
}
