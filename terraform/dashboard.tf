resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = "${ var.prefix }-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "${ var.prefix }-dashboard",
              "get_hello_world.count"
            ]
          ]
          period = 60
          stat   = "Sum"
          region = "eu-west-1"
          title  = "How many GET received"
        }
      }
    ]
  })
}