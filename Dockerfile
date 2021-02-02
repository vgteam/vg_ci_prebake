FROM quay.io/vgteam/dind
MAINTAINER anovak@soe.ucsc.edu

# We basically pre-do all of vg's .gitlab-ci.yml setup. vg won't rely on this
# being done, but it should make things faster if packages are already
# installed.
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
        docker.io \
        python3-pip \
        python3-virtualenv \
        libcurl4-gnutls-dev \
        python3-dev \
        npm \
        nodejs \
        node-gyp \
        uuid-runtime \
        awscli \
        jq && \
    apt-get clean && \
    npm install -g junit-merge && \
    npm install -g txm

# We can't pre-pull any Docker images, because that would require starting up
# all of dockerd, and it refuses to start in a non-priveleged container. This
# may be fixable soon with "rootless" support in Docker. See
# https://github.com/moby/moby/issues/38698
