data "google_client_config" "provider" {}

data "google_container_cluster" "glb-demo-cluster-us" {
  name     = "glb-demo-cluster-us"
  location = "us-central1-a"
}

provider "kubectl" {
  load_config_file       = false
  host                   = "https://${data.google_container_cluster.glb-demo-cluster-us.endpoint}"
  #token                  = "${data.google_container_cluster.glb-demo-cluster-eu.access_token}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = "${base64decode(data.google_container_cluster.glb-demo-cluster-us.master_auth.0.cluster_ca_certificate)}"
}

data "kubectl_filename_list" "us-manifests" {
    pattern = "./manifests/*.yaml"
}

resource "kubectl_manifest" "us-service" {
    count = length(data.kubectl_filename_list.us-manifests.matches)
    yaml_body = file(element(data.kubectl_filename_list.us-manifests.matches, count.index))
}
