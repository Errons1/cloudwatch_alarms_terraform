resource "aws_cloudwatch_dashboard" "hello_world" {
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
              var.student_name,
              "hello_world.value",
              "hello_world.count"
            ]
          ]
          period = 60
          stat   = "Sum"
          region = "eu-west-1"
          title  = "How many GET received"
        }
      },
      {
        type   = "text"
        x      = 0
        y      = 7
        width  = 3
        height = 3

        properties = {
          markdown = "This is markdown"
        }
      }
    ]
  })
}