[
  {
  "name": "mongo-express",
    "image": "docker.io/mongo-express:latest",
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/myapp",
          "awslogs-region": "eu-west-2",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": 8081,
        "hostPort": 8081
      }
    ],
    "healthCheck": {
        "command": [
          "CMD-SHELL",
          "echo hello"
        ],
        "interval": 5,
        "timeout": 2,
        "retries": 3
    },
    "environment": [
      {
        "name": "ME_CONFIG_MONGODB_ADMINUSERNAME",
         "value": "admin"
      },
      {
        "name": "ME_CONFIG_MONGODB_ADMINPASSWORD",
         "value": "password"
      },
      {
        "name": "ME_CONFIG_MONGODB_SERVER",
         "value": "localhost"
      }
    ],
    "dependsOn": [
        {
          "containerName": "mongodb",
          "condition": "HEALTHY"
        }
    ] 
  },
  
  {
    "name": "mongodb",
    "image": "docker.io/mongo:latest",
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/myapp",
          "awslogs-region": "eu-west-2",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": 27017,
        "hostPort": 27017
      }
    ],
    "healthCheck": {
        "command": [
          "CMD-SHELL",
          "echo hello"
        ],
        "interval": 5,
        "timeout": 2,
        "retries": 3
    },
    "environment": [
      {
        "name": "MONGO_INITDB_ROOT_USERNAME",
         "value": "admin"
      },
      {
        "name": "MONGO_INITDB_ROOT_PASSWORD",
         "value": "password"
      }
    ]    
  }
    
]