[   
  {
    "name": "mongo-express",
    "image": "396057208705.dkr.ecr.eu-west-2.amazonaws.com/my-mongo-express:6.0",
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
         "value": "mongodb"
      }
    ]
  }
]