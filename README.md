## ---------------------------------------------------------------------------
#  Project: lab051b-build-terraform-fargate
## Purpose: This project creates a loadbalanced fargate infrastructure used to host a   
##          simple app that is run inside three interconnected docker containers on 
##          the AWS cloud platform.
   Author:  Frank Effrim-Botchey
## ----------------------------------------------------------------------------

This project is part of a jenkins pipeline which monitors changes in my other git repo (lab051a-build-docker-image).

The following is performed when changes are detected in the repo.

  [1] Jenkins clones lab051a-build-docker-image from Git repo and builds a new docker image.
  
  [2] Jenkins pushed the new image to Docker Hub.
  
  [3] Jenkins clones this Git repo (lab051b-build-terraform-fargate) and directs Terraform to build the aws cloud infrastructure.
  
  [4] Terraform pulls the docker image from Docker Hub...
      and runs the app inside docker containers hosted on load balanced infrastucture publicly accessible in the aws cloud.
