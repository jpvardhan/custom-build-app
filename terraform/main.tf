provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "custom_nodejs_build" {
  name = "custom-nodejs-build"
}

resource "null_resource" "build_and_push_latest" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Building latest image..."
      docker build -f ../docker/Dockerfile.latest -t custom-nodejs-build:latest ../docker > /dev/null 2>&1

      echo "Logging into ECR..."
      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.custom_nodejs_build.repository_url} > /dev/null 2>&1

      echo "Tagging latest image..."
      docker tag custom-nodejs-build:latest ${aws_ecr_repository.custom_nodejs_build.repository_url}:latest > /dev/null 2>&1

      echo "Pushing latest image to ECR..."
      docker push ${aws_ecr_repository.custom_nodejs_build.repository_url}:latest

      echo "✅ Latest Image Build and Push Successful!"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [aws_ecr_repository.custom_nodejs_build]
}

resource "null_resource" "build_and_push_enhanced" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Building enhanced image..."
      docker build -f ../docker/Dockerfile.enhanced -t custom-nodejs-build:enhanced ../docker > /dev/null 2>&1

      echo "Logging into ECR..."
      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.custom_nodejs_build.repository_url} > /dev/null 2>&1

      echo "Tagging enhanced image..."
      docker tag custom-nodejs-build:enhanced ${aws_ecr_repository.custom_nodejs_build.repository_url}:enhanced > /dev/null 2>&1

      echo "Pushing enhanced image to ECR..."
      docker push ${aws_ecr_repository.custom_nodejs_build.repository_url}:enhanced

      echo "✅ Enhanced Image Build and Push Successful!"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [aws_ecr_repository.custom_nodejs_build]
}
