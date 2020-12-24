[
   {
    "name": "mongodb",
    "image": "docker.io/mongo:latest",
    "networkMode": "awsvpc",
    "essential": true,
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
  },
  
  
  {
    "name": "my-app",
    "image": "396057208705.dkr.ecr.eu-west-2.amazonaws.com/my-app:local3.0",
    "networkMode": "awsvpc",
    "essential": false,
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
        "containerPort": ${my-cd-port},
        "hostPort": ${my-cd-port}
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
    "command": [
      "node", "server.js"
    ],
    "dependsOn": [
        {
          "containerName": "mongodb",
          "condition": "HEALTHY"
        }
    ] 
  },

  {
    "name": "mongo-express",
    "image": "396057208705.dkr.ecr.eu-west-2.amazonaws.com/my-mongo-express:6.0",
    "networkMode": "awsvpc",
    "essential": false,
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
         "value": "mongodb"
      }
    ],
    "dependsOn": [
        {
          "containerName": "mongodb",
          "condition": "HEALTHY"
        }
    ] 
  }
]