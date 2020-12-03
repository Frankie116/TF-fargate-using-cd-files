# variables.tf

variable "my-aws-region" {
  description = "The AWS region things are created in"
  default     = "eu-west-2"
}

variable "my-ecs-task-execution-role-name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "my-az-count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "my-docker-image" {
  description = "Docker image to run in the ECS cluster"
  default     = "nginx:latest"
}

variable "my-docker-port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "my-desired-container-count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "my-health-check-path" {
  default = "/"
}

variable "my-desired-fargate-cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "my-desired-fargate-memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}