FROM quay.io/vgteam/dind
MAINTAINER anovak@soe.ucsc.edu

# We basically pre-do all of vg's .gitlab-ci.yml setup.
# vg won't rely on this being done, but it should make things faster if packages are already installed.
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

# Debug wrapdocker startup
ENV LOG=console

# Also grab all the Dockers we want in the container.
# Depends on fetching this external file; pre-loads whatever master toil-vg wants to use.
# We need to do docker things through wrapdocker which starts the daemon up for us.
RUN curl https://raw.githubusercontent.com/vgteam/toil-vg/master/src/toil_vg/vg_config.py | \
    grep docker: | \
    grep -v vg | \
    awk '{print $2}' | \
    sed "s/^\([\"']\)\(.*\)\1\$/\2/g" | \
    sort | \
    uniq | \
    wrapdocker xargs -n 1 docker pull
