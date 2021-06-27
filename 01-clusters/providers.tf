
terraform {
  required_version = "~> 0.12"

  required_providers {
  kubectl = {
    source  = "gavinbunney/kubectl"
    version = ">= 1.7.0"
  }
}
}

provider "google" {
  version = 3.67
  project = var.project_id
  region  = "global"
  credentials = var.credential_path
}
