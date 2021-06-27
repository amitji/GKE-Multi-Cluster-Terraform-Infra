# gke-multi-cluster-terraform-infra

This is a demo of how to setup a Global load balancer across GKE Clusters in Multiple Regions in Google Cloud Platform (GCP) and automate it with Terraform scripts. 

**This is a demo only, not for Production use.**
Its not secure and robust to run as is in Prod or similar environments, this is only designed for quickly showing
how to set it up and how Resiliency and failover works. 
Make sure you cleanup all resources once done as mentioned in the '06-cleanup' folder.

## Step 00 - Credential
Download the credentila file for service account from GCP and save it in a directory as "service-account.json".
provide this path in terraform.tfvars file. 

## Step 01 - Create the Clusters

Enter the `01-clusters/` directory, initialise Terraform, and apply the project files.

```
terraform init
terraform apply
```

Ensure the plan looks correct and then enter `yes`.

## Step 02 - Register to Hub

Enter the `02-hub-register/` directory.

```
terraform init
terraform apply
```


## Step 03 - Create resources using manifest files for Europe Cluster 

Enter the `03-kube-eu/` directory.

```
terraform init
terraform apply
```

## Step 04 - Create resources using manifest files for US Cluster 

Enter the `03-kube-us/` directory.

```
terraform init
terraform apply
```

## Step 05 - Manual Step

Read instructions in README.md in folder `05-manual-steps` and follow through.

## Step 06 - CLEANUP step, Important ! 

Read instructions in README.md in folder `06-cleanup` and follow through.