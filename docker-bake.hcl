
target "common" {
  tags = [
    "docker.io/kiwigrid/k8s-sidecar:latest",
    "quay.io/kiwigrid/k8s-sidecar:latest",
    "ghcr.io/kiwigrid/k8s-sidecar:latest",
  ]
}

# Target for amd64 and arm64
target "k8s-sidecar-main" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
}

# Target for armv7
target "k8s-sidecar-armv7" {
  inherits = ["common"]
  dockerfile = "Dockerfile.armv7"
  platforms = ["linux/arm/v7"]
}

# The default group builds both targets
group "default" {
  targets = ["k8s-sidecar-main", "k8s-sidecar-armv7"]
}
