BRANCH "master" 
Changelog-001
Initial code copied from https://github.com/AjeetK/terraform-ecs-fargate.git

Changelog-002
Refactored code

Changelog-003
Refactored code - changed variable names

Changelog-004
Refactored code.
Used vpc module instead of resource. (replacing network.tf with 1a-vpc.tf)
Added terraform.tfvars
Updated variables.tf
Added 9b-random-string.tf

Changelog-005
Refactored security groups.  
Added security rules

Changelog-006
Refactored code.


Changelog-007
Refactored code.


Changelog-008
Added template & s3 files

Changelog-009
Refactored. 
Added route53 to enable private dns zone to be used.
Still need to resolve autoscaling issue. (currrent docker container requires port 8080, however, lb target group health checks are failing on port 8080. Therefore, auto scaling is constantly stopping/starting fargate tasks.  Health checks pass on port 80 though.)

Changelog-010
Resolved autoscaling issue by updating the lb health checks to monitor "/login" in the path instead of just "/".