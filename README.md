# Cekit Behave steps -- Podman edition

This branch is intended to be a home for work to get behave-test-steps to work
with Podman.

Ideally we will continue to work with Docker as well, but the initial priority
is Podman support even at the expense of Docker.

## Preparation

Podman v2.x+ features a REST API which is docker-compatible but also extends it
with more stuff from the libpod API.

See <https://docs.podman.io/en/latest/_static/api.html>

Starting the API endpoint as a user

    podman system service -t 5000 # lifetime in seconds. -t 0 = forever

socket is `/run/user/$(id -u)/podman/podman.sock`

Note: there are packages to set this up as a replacement for the docker daemon
socket (`podman-docker` RPM). We don't rely on this because we want to support
concurrent use of podman and docker.

You *might* have systemd sockets and services defined to start the daemon

    systemctl --user enable podman.service
    systemctl --user start podman.service


## Testing

Set the environment variable `CTF_API_SOCK` to a URI corresponding to the Podman
socket, e.g.

    export CTF_API_SOCK=unix:///run/user/1000/podman/podman.sock

Run a test using cekit, e.g.

    cekit --descriptor ubi8-openjdk-11.yaml test behave --wip \
        --steps-url https://github.com/jmtd/behave-test-steps \
        --steps-ref podman
