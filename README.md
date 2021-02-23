----------------------------------------------------------------------------
#  Project: TF-fargate-using-cd-files

Purpose: This project creates a loadbalanced fargate infrastructure using Terraform & Jenkins. 

A simple app is run inside three interconnected docker containers on the AWS cloud platform.

Author:  Frank Effrim-Botchey
   
Library: https://github.com/Frankie116/my-library.git
   
----------------------------------------------------------------------------

This project is part of a jenkins pipeline which monitors changes in my other git repo (lab051a-build-docker-image).

The following is performed when changes are detected in the repo.

  [1] Jenkins clones "DOCKER-profile-app-mongodb" from github repo and builds a new docker image.
  
  [2] Jenkins pushes the new image to Docker Hub.
  
  [3] Jenkins clones this git repo and directs Terraform to build the aws cloud infrastructure.
  
  [4] Terraform pulls the docker image from Docker Hub...
      and runs the app inside docker containers hosted on load balanced infrastucture publicly accessible in the aws cloud.
