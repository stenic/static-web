# Static Web

Tiny static webserver running as non-root with support for amd64, arm/v7 and arm64.

## Usage

```
docker run -ti \
    -v $(pwd)/web:/web \
    -p 8080:8080 \
    stenicbv/static-web:v0.0.2
```
