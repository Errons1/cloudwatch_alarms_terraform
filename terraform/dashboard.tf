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
              "get_hello.count"
            ]
          ]
          period = 60
          stat   = "Sum"
          region = "eu-west-1"
          title  = "How many GET served"
        }
      }
    ]
  })
}

module "alarm" {
  source = "github.com/Errons1/aws_alarm.git"
  prefix = "snle"
  alarm_name = "amount-of-get-request"
  alarm_namespace = "snle-dashboard"
  metric_name = "Sum"
  comparison_operator = "GreaterThanThreshold"
  threshold = "50"
  evaluation_periods = "2"
  period = "60"
  statistic = "Sum"
  alarm_description = "Amoung of get requests"
  protocol = "email"
  endpoint = "snorreledal@hotmail.no"
}