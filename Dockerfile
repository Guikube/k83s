##
# multi-build args
##
ARG AUTHORS="@guikube_atlas"
ARG VERSION="0.1.0"
ARG USER="atlas"
ARG HOMEDIR="${USER}"

FROM golang:latest AS dev

#> define args & labels
ARG VERSION
ARG USER
ARG HOMEDIR
LABEL org.container.image.authors=${AUTHORS}

#> create user & group
RUN useradd --home-dir ${HOMEDIR} --user-group ${USER}

#> switch user
USER ${USER}
WORKDIR ${HOMEDIR}

FROM golang:alpine

#> Labels
LABEL org.label-schema.schema-version="0.1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="<dockerhub-username>/<container-name>"
LABEL org.label-schema.description="<description>"
LABEL org.label-schema.url="<nothingIguess>"
LABEL org.label-schema.vcs-url="https://github.com/Guikube/k8sSecurityScanner"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="<meIguess>"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run k83s"