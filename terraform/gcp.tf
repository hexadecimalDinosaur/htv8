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
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "project_subnet" {
    network = google_compute_network.project_vpc
    name = "{{ project_name }}-pub-subnet"
    ip_cidr_range = "10.0.1.1/24"
    region = "{{ gcp_region }}"
}

resource "google_compute_instance" "project_webserver" {
    name = "{{ project_name }}-webserver"
    machine_type = "{{ compute_type }}"
    hostname = "{{ project_name }}"
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian11"
      }
    }
    scratch_disk {
      interface = "NVME"
    }
    network_interface {
      network = google_compute_network.project_vpc
      subnetwork = google_compute_subnetwork.project_subnet
      access_config {}
    }
}

{% if managed_db %}
resource "google_sql_database_instance" "project_managed_db" {
    name = "{{ project_name }}-db"
    database_version = "{{ managed_db_version }}"
    settings {
      tier = "{{ managed_db_tier }}"
      ip_configuration {
        ipv4_enabled = false
        private_network = google_compute_network.project_vpc
      }
    }
}
{% endif %}
