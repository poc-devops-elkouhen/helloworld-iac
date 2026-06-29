terraform {
  required_version = ">= 1.5.0"

  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 17.0"
    }
  }
  # Le backend est injecté par tf-controller via backendConfig.secretSuffix
}
