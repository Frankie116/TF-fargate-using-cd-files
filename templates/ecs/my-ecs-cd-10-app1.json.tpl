[
   {
    "name": "${my-cd-application}",
    "image": "396057208705.dkr.ecr.eu-west-2.amazonaws.com/my-app:docker8.05",
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
        "containerPort": 3000,
        "hostPort": 3000
      }
    ],
    "command": [
      "node", "server.js"
    ]
  }
]