terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.7.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.9.2"
    }
  }

  backend "local" {
    # Run `make np` or `make pr` to set the proper tfstate file for each environment
  }
}

provider "google" {
  region = var.region
}