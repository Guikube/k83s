#>> multi-build args
ARG AUTHORS="@guikube_atlas"
ARG VERSION="0.1.0"
ARG USER="atlas"
ARG HOMEDIR="/${USER}"

#>> builder stage
FROM golang:latest AS builder

COPY ./ /build-dir

WORKDIR /build-dir

RUN go build -o /k83s /build-dir

#>> runner stage
FROM golang:latest

#> define args & labels
ARG VERSION
ARG USER
ARG HOMEDIR
LABEL org.container.image.authors=${AUTHORS}
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="<dockerhub-username>/<container-name>"
LABEL org.label-schema.description="<description>"
LABEL org.label-schema.vcs-url="https://github.com/Guikube/k8sSecurityScanner"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run k83s"

#> create user & group
RUN useradd --home-dir ${HOMEDIR} --user-group ${USER}

#> switch user
USER ${USER}
WORKDIR ${HOMEDIR}

COPY --from=builder /k83s /usr/local/bin/k83s

CMD [ "k83s" ]
