# Static Web

Tiny static webserver running as non-root with support for amd64, arm/v7 and arm64.

> In order to allow for more control, this now includes nginx. This got the image to ~20MB.

## Usage

```
docker run -ti \
    -v $(pwd)/web:/web \
    -p 8080:8080 \
    ghcr.io/stenic/static-web:latest
```
