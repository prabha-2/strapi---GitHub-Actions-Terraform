variable "docker_username" {
  description = "Docker Hub username"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag (from CI)"
  type        = string
}

variable "key_name" {
  description = "AWS EC2 Key Pair name"
  type        = string
}
