#>> multi-build args
ARG AUTHORS="@guikube_atlas"
ARG VERSION="0.1.0"
ARG USER="atlas"
ARG HOMEDIR="/${USER}"

#>> builder stage
FROM golang:latest AS builder

#> create & populate build directory
COPY ./ /build-dir
WORKDIR /build-dir

#> build binary
RUN go build -o /k83s .

#>> runner stage
FROM golang:alpine

#> define args & labels
ARG VERSION
ARG USER
ARG HOMEDIR

#> create user & group
RUN addgroup -S ${USER} && adduser -h ${HOMEDIR} -S ${USER} -G ${USER}

#> switch user
USER ${USER}
WORKDIR ${HOMEDIR}

#> retreive binary
COPY --from=builder /k83s /usr/local/bin/k83s

#> run binary
CMD [ "k83s" ]
