FROM golang:alpine AS gobuilder

WORKDIR /go/src/static-web
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN apk add --update gcc musl-dev

COPY . /go/src/static-web
RUN CGO_ENABLED=0 go build --tags "linux"


FROM scratch
WORKDIR /
COPY --from=gobuilder /go/src/static-web/static-web /static-web
COPY --from=gobuilder /etc/passwd /etc/passwd
COPY --from=gobuilder /etc/group /etc/group

USER appuser
CMD ["/static-web"]