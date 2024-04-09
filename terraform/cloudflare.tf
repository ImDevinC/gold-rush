locals {
  cloudflare_account_id = "160dde3020d94b782e2085939a53c2d6"
}

resource "cloudflare_zone" "main" {
  account_id = local.cloudflare_account_id
  zone       = "isitgoldrush.com"
  jump_start = true
}

resource "cloudflare_pages_project" "main" {
  depends_on        = [cloudflare_zone.main]
  account_id        = local.cloudflare_account_id
  name              = "isitgoldrush"
  production_branch = "main"

  build_config {
    build_caching   = false
    build_command   = "exit 0"
    destination_dir = "src"
  }

  source {
    type = "github"
    config {
      owner             = "ImDevinC"
      production_branch = "main"
      repo_name         = "gold-rush"
    }
  }
}

resource "cloudflare_pages_domain" "main" {
  account_id   = local.cloudflare_account_id
  project_name = cloudflare_pages_project.main.name
  domain       = "isitgoldrush.com"
}
