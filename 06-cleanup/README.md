- DO NOT FORGET TO DESTROY ALL THE RESOURCES IN GCP. 
- RUN terraform destroy in reverse order in each of following directory -
    - 04-kube-us> terraform destroy
    - 03-kube-eu> terraform destroy
    - 02-hub-register> terraform destroy
    - 01-clusters> terraform destroy
