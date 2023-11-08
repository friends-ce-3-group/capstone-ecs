# output "alb_dns" {
#   value = module.ecs_services.alb_dns
# }


# resource "local_file" "write_url" {
#   content  = "ALB_DNS_URL=${module.ecs_services.alb_dns}"
#   filename = "${path.module}/alb_dns_url.dat"
# }