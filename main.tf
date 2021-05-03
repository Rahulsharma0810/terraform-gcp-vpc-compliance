terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.66.1"
    }
  }
}

provider "google" {
  project     = var.project
  region      = "us-west-2"
}

data "google_client_config" "default" {}

locals {
  project-id = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
}

resource "google_compute_network" "default" {
    name                    = var.name
    project                 = local.project-id
    auto_create_subnetworks = var.auto_create_subnetworks
    routing_mode            = var.routing_mode
}

/******************************************
	SUBNET configuration
 *****************************************/

resource "google_compute_subnetwork" "subnet-with-logging" {
  name          = "log-test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.default.self_link

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_network" "custom-test" {
  name                    = "log-test-network"
  auto_create_subnetworks = false
}
