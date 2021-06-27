data "google_client_config" "provider" {}

data "google_container_cluster" "glb-demo-cluster-eu" {
  name     = "glb-demo-cluster-eu"
  project = var.project_id
  location = var.zone-eu
}

data "google_container_cluster" "glb-demo-cluster-us" {
  name     = "glb-demo-cluster-us"
  project = var.project_id
  location = var.zone-us
}


module "hub-eu" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/hub"

  project_id       = var.project_id
  cluster_name     = data.google_container_cluster.glb-demo-cluster-eu.name
 
  # location         = module.primary-cluster.location
  # cluster_endpoint = module.primary-cluster.endpoint
  location         =  var.zone-eu
  cluster_endpoint = data.google_container_cluster.glb-demo-cluster-eu.endpoint
  # gke_hub_membership_name = "eu-hub-mem"
  # gke_hub_sa_name = "eu-hub-mem"
  gke_hub_membership_name = "glb-eu"
  gke_hub_sa_name = "eu-hub-mem"
}

module "hub-us" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/hub"

  project_id       = var.project_id
  cluster_name     = data.google_container_cluster.glb-demo-cluster-us.name
 
  # location         = module.primary-cluster.location
  # cluster_endpoint = module.primary-cluster.endpoint
  location         = var.zone-us
  cluster_endpoint = data.google_container_cluster.glb-demo-cluster-us.endpoint
  # gke_hub_membership_name = "us-hub-mem"
  # gke_hub_sa_name = "us-hub-mem"
  gke_hub_membership_name = "glb-us"
  gke_hub_sa_name = "us-hub-mem"
}
