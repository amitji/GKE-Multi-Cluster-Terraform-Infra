data "google_client_config" "provider" {}

data "google_container_cluster" "glb-demo-cluster-eu" {
  name     = "glb-demo-cluster-eu"
  location = "europe-west1-c"
}
provider "kubectl" {
  load_config_file       = false
  host                   = "https://${data.google_container_cluster.glb-demo-cluster-eu.endpoint}"
  #token                  = "${data.google_container_cluster.glb-demo-cluster-eu.access_token}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = "${base64decode(data.google_container_cluster.glb-demo-cluster-eu.master_auth.0.cluster_ca_certificate)}"
}

data "kubectl_filename_list" "eu-manifests" {
    pattern = "./manifests/*.yaml"
}

resource "kubectl_manifest" "eu-service" {
    count = length(data.kubectl_filename_list.eu-manifests.matches)
    yaml_body = file(element(data.kubectl_filename_list.eu-manifests.matches, count.index))
}

# resource "kubectl_manifest" "my_service" {
#     yaml_body = file("${path.module}/deploy.yaml")
# }

