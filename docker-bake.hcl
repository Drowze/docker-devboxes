variable "IMAGE" {
  default = "devbox"
}

group "default" {
  targets = ["debian"]
}

# Populated by metadata-action in CI; empty for local builds.
target "docker-metadata-action" {}

target "debian" {
  name = "debian-${codename}"
  matrix = {
    codename = ["trixie", "bookworm"]
  }

  inherits = ["docker-metadata-action"]
  platforms = ["linux/amd64", "linux/arm64"]
  context = "./debian"

  args = {
    DEBIAN_VERSION_CODENAME = codename
  }

  tags = concat(
    ["${IMAGE}:debian-${codename}"],
    codename == "trixie" ? ["${IMAGE}:latest", "${IMAGE}:debian"] : []
  )

  labels = {
    "org.opencontainers.image.version" = "debian-${codename}"
  }
}
