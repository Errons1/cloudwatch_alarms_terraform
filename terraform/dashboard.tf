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
      },
      {
        type   = "number"
        x      = 6
        y      = 0
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "${ var.prefix }-dashboard",
              "post_hello.count"
            ]
          ]
          sparkline            = true,
          view                 = "singleValue",
          stat                 = "Sum"
          period               = 60
          setPeriodToTimeRange = true
          region               = "eu-west-1"
          title                = "How many POST received"
        }
      }
      #      {
      #        type   = "number"
      #        x      = 6
      #        y      = 0
      #        width  = 6
      #        height = 6
      #        
      #        properties = {
      #          metrics = [
      #            [
      #              "${ var.prefix }-dashboard",
      #              "post_hello.count"
      #            ]
      #          ]
      #          sparkline = true,
      #          view      = "singleValue",
      #          region    = "eu-west-1",
      #          stat      = "Sum",
      #          period    = 60
      #        }
      #      }
    ]
  })
}