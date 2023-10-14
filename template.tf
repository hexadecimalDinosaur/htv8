terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "4.51.0"
        }
    }
}

provider "google" {
    project = "{{ project_id }}"
    region = "{{ project_region }}"
    zone = "{{ project_zone }}"
}

