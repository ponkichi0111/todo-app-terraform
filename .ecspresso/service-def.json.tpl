{
  "serviceName": "todo-service",
  "desiredCount": 1,
  "launchType": "FARGATE",
  "loadBalancers": [
    {
      "targetGroupArn": "${TARGET_GROUP_ARN}",
      "containerName": "todo-frontend",
      "containerPort": 80
    }
  ],
  "networkConfiguration": {
    "awsvpcConfiguration": {
      "subnets": [
        "${SUBNET_1}",
        "${SUBNET_2}"
      ],
      "securityGroups": [
        "${SECURITY_GROUP_ID}"
      ],
      "assignPublicIp": "DISABLED"
    }
  }
}
