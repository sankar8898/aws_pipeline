# Required Packer version
packer {
  required_version = ">= 1.7.0"

  required_plugins {
    docker = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/docker"
    }
  }
}

# Source block for Docker
source "docker" "ubuntu" {
  image  = "ubuntu:20.04"
  commit = true
}

# Build block using the above Docker source
build {
  name    = "docker-ubuntu-build"
  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y nginx",
      "echo 'Hello from Packer Docker!' > /var/www/html/index.html"
    ]
  }
}
