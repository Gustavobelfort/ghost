terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "gustavo-sandbox"

    workspaces {
      name = "ghost"
    }
  }
}
