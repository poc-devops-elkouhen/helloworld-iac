variable "gitlab_url" {
  description = "URL de base de l'instance GitLab"
  type        = string
  default     = "http://gitlab-webservice-default.gitlab.svc:8181"
}

variable "gitlab_token" {
  description = "Personal access token GitLab (scopes: api, read_repository, write_repository)"
  type        = string
  sensitive   = true
}
