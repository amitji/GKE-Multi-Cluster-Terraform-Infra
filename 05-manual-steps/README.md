1. MultiClusterService & MultiClusterIngress are not supporteed in Terraform yet so you will need to run
manifest files for these in gcloud manually.

2. Steps - 
    - see what are contexts -  
      >> kubectl config get-contexts -o name
    - switch to one of the region cluster i.e. US - 
        >> kubectl config use-context gke_project-gke-multicluster_us-central1-a_glb-demo-cluster-us
    - run following - 
      >> gcloud container clusters get-credentials glb-demo-cluster-us --zone us-central1-a
         gcloud container clusters get-credentials glb-demo-cluster-eu --zone europe-west1-c
    - Enable Multi-cluster Ingress and select cluster in US as the config cluster -
      >> gcloud alpha container hub ingress update --config-membership=projects/project-gke-multicluster/locations/global/memberships/glb-us

    - upload the mci.yaml & mcs.yaml via gcloud console
    - run MCS and MCI manifest files... 
      >>  kubectl apply -f mcs.yaml
      - At this time you might get error for Auth login. Do as instructed in the error to authenticate yourself.
    -  >> kubectl apply -f mci.yaml
    - verify if these twodeployments has gone right 
      >>  kubectl describe mci zone-ingress -n zoneprinter
    - You will see VIP: towards the bottom of output. If you dont see it , wait for 2-3 minutes.
    - take the VIP and hit in browser. It should show welcome page from nearest region and flag of hosting country.

3. Some useful gcloud commands to test Resiliency and Failover to another region. Open a gcloud terminal in GCP and - 
    - Check what all context you have right now. You should see two, one for US and one for EU. 
        > kubectl config get-contexts

    -   See Current context. 
        > kubectl config current-context   

    -  See the pods in current cluster. There should be 2 pods running - 
        > kubectl get pod --namespace zoneprinter -o wide
    - Silimalry switch to other context and see pods - 
      > kubectl config use-context <other context name>
      > kubectl get pod --namespace zoneprinter -o wide
    
    - If your browser shows you US region flag then lets try to bring down the all US pods. Thats means no pods in US region and when you again hit the VIP in browser , it will take you to the other region. Thats means GCP autimatically failedover to other region. Thats all the magix is all about !!!!  

    
