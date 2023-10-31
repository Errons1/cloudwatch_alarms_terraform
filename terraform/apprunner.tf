resource "aws_apprunner_service" "apprunner" {
  service_name = "${ var.prefix }-apprunner"
  
  instance_configuration {
    instance_role_arn = aws_iam_role.apprunner_role.arn
  }
  
  source_configuration {
    
    authentication_configuration {
      access_role_arn = "arn:aws:iam::244530008913:role/service-role/AppRunnerECRAccessRole"
    }
    
    
    image_repository {
      image_configuration {
        port = "8080"
      }
      image_identifier      = var.image
      image_repository_type = "ECR"
    }
    
    auto_deployments_enabled = true
  }
}
