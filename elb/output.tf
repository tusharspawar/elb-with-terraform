output "web_app_elb_id" {
  value = aws_elb.web_app.id
}

output "web_app_elb_name" {
  value = aws_elb.web_app.name
}

output "web_app_elb_dns_name" {
  value = aws_elb.web_app.dns_name
}
