# NordVPN Docker Image

Docker image for NordVPN with automated build and publish workflow to GitHub Container Registry.

## Building and Publishing

This repository uses GitHub Actions to automatically build and publish the Docker image to GitHub Container Registry whenever changes are pushed to the main branch.

### Prerequisites

No special prerequisites needed - the workflow uses GitHub's built-in authentication via `GITHUB_TOKEN`.

### Workflow

The workflow file `.github/workflows/docker-publish.yml` handles:
- Checking out the code
- Setting up Docker Buildx
- Logging into GitHub Container Registry
- Building and pushing the image to GitHub Container Registry

The image will be published with two tags:
- `ghcr.io/gabriel.poleze/nordvpn-image:latest`
- `ghcr.io/gabriel.poleze/nordvpn-image:<commit-hash>`

## Usage

To use this image:

```bash
docker run -it --privileged \
  -e NORDVPN_TOKEN=your_token_here \
  ghcr.io/gabriel.poleze/nordvpn-image:latest
```

Note: The container requires privileged access for NordVPN to function properly.