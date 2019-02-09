FROM quay.io/vgteam/dind
MAINTAINER anovak@soe.ucsc.edu

# We basically pre-do all of vg's .gitlab-ci.yml setup. vg won't rely on this
# being done, but it should make things faster if packages are already
# installed.
RUN apt-get -q -y update && \
    apt-get -q -y install \
        docker.io \
        python-pip \
        python-virtualenv \
        libcurl4-gnutls-dev \
        python-dev \
        npm \
        nodejs \
        node-gyp \
        nodejs-dev \
        libssl1.0-dev \
        uuid-runtime && \
    npm install -g junit-merge

# We can't pre-pull any Docker images, because that would require starting up
# all of dockerd, and it refuses to start in a non-priveleged container. This
# may be fixable soon with "rootless" support in Docker. See
# https://github.com/moby/moby/issues/38698
