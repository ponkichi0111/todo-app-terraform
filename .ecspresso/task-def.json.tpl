{
  "family": "todo-app-task",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "512",
  "memory": "1024",
  "networkMode": "awsvpc",
  "executionRoleArn": "${IAM_ROLE_TASK_EXECUTION}",
  "taskRoleArn": "${IAM_ROLE_APP_TASK}",
  "containerDefinitions": [
    {
      "name": "todo-backend",
      "image": "${ECR_BACKEND_REPO_NAME}:latest",
      "portMappings": [
        {
          "containerPort": 4000
        }
      ],
      "essential": true,
      "secrets": [
        {
          "name": "DB_USER",
          "valueFrom": "${DB_USER}"
        },
        {
          "name": "DB_PASSWORD",
          "valueFrom": "${DB_PASSWORD}"
        }
      ],
      "environment": [
        {
          "name": "NODE_ENV",
          "value": "production"
        },
        {
          "name": "DB_HOST",
          "value": "${DB_HOST}"
        },
        {
          "name": "DB_NAME",
          "value": "${DB_NAME}"
        }
      ]
    },
    {
      "name": "todo-frontend",
      "image": "${ECR_FRONTEND_REPO_NAME}:latest",
      "portMappings": [
        {
          "containerPort": 80
        }
      ],
      "essential": true
    }
  ]
}
