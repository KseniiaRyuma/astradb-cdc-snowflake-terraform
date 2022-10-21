terraform {
  cloud {
    organization = "Kryuma-org"

    workspaces {
      name = "cli-workspace"
    }
  }
}