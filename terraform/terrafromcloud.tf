terraform {
  backend "remote" {
    organization = "itea-test"

    workspaces {
      name = "itea"
    }
  }
}