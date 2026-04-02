# This variable will be populated by the github-tag-action output
variable "TAG" {
  default = "latest"
}

# Define the common tags for all builds
target "common-tags" {
  tags = [
    "docker.io/kiwigrid/k8s-sidecar:latest",
    "docker.io/kiwigrid/k8s-sidecar:${TAG}",
    "quay.io/kiwigrid/k8s-sidecar:latest",
    "quay.io/kiwigrid/k8s-sidecar:${TAG}",
    "ghcr.io/kiwigrid/k8s-sidecar:latest",
    "ghcr.io/kiwigrid/k8s-sidecar:${TAG}"
  ]
}

# Define the default build which will be a combination of the others
group "default" {
  targets = ["k8s-sidecar"]
}

# Define the matrix build
target "k8s-sidecar" {
  inherits = ["common-tags"]
  # build matrix for platforms using different dockerfiles
  matrix = {
    "platform-ext" = [
      "",
      ".armv7"
    ]
  }
  dockerfile = "Dockerfile${matrix.platform-ext}"
  # set the platform for each matrix entry
  platforms = lookup({
    "" = [
      "linux/amd64",
      "linux/arm64"
    ]
    ".armv7" = [
      "linux/arm/v7"
    ]
  }, matrix.platform-ext)
}
