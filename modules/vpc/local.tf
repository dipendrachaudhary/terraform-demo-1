locals {
  main_tags = {
    Name    = var.vpc_name
    //Created = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
  public_route_tags = {
    Name    = "main-public"
    //Created = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
  private_route_tags = {
    Name    = "main-private"
    //Created = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
}
