resource "google_container_cluster" "glb-demo-cluster-us" {
  name               = "glb-demo-cluster-us"
  location           = var.zone-us
  remove_default_node_pool = true
  initial_node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.1.0.0/16"
    services_ipv4_cidr_block = "10.2.0.0/16"
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}


resource "google_container_node_pool" "us_nodes" {
  name       = "${google_container_cluster.glb-demo-cluster-us.name}-node-pool"
  location   = var.zone-us
  cluster    = google_container_cluster.glb-demo-cluster-us.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    # machine_type = "n1-standard-1"
    machine_type = "e2-micro"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}



resource "google_container_cluster" "glb-demo-cluster-eu" {
  name               = "glb-demo-cluster-eu"
  location           = var.zone-eu
  remove_default_node_pool = true
  initial_node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.3.0.0/16"
    services_ipv4_cidr_block = "10.4.0.0/16"
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_container_node_pool" "eu_nodes" {
  name       = "${google_container_cluster.glb-demo-cluster-eu.name}-node-pool"
  location   = var.zone-eu
  cluster    = google_container_cluster.glb-demo-cluster-eu.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    preemptible  = true
    # machine_type = "n1-standard-1"
    machine_type = "e2-micro"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

