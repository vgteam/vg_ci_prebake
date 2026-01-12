FROM quay.io/vgteam/dind
MAINTAINER anovak@soe.ucsc.edu

# Make sure that package update and installation happens fresh every time this
# file is touched.
ADD prebake-build-timestamp.txt /etc/prebake-build-timestamp.txt

# We basically pre-do all of vg's .gitlab-ci.yml setup. vg won't rely on this
# being done, but it should make things faster if packages are already
# installed.
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
        make git build-essential protobuf-compiler libprotoc-dev libjansson-dev libbz2-dev \
        libncurses5-dev automake libtool jq bsdmainutils bc rs parallel npm samtools curl \
        unzip redland-utils librdf-dev cmake pkg-config wget gtk-doc-tools raptor2-utils \
        rasqal-utils bison flex gawk libgoogle-perftools-dev liblz4-dev liblzma-dev \
        libcairo2-dev libpixman-1-dev libffi-dev libcairo-dev libprotobuf-dev libboost-all-dev \
        docker.io python3-pip python3-virtualenv libcurl4-gnutls-dev python-dev-is-python3 npm nodejs node-gyp uuid-runtime libgnutls28-dev doxygen pybind11-dev python3-pybind11 \
        uuid-runtime \
        awscli && \
    apt-get clean && \
    npm install -g junit-merge@2.0.0 && \
    npm install -g txm@7.4.5

# We can't pre-pull any Docker images, because that would require starting up
# all of dockerd, and it refuses to start in a non-priveleged container. This
# may be fixable soon with "rootless" support in Docker. See
# https://github.com/moby/moby/issues/38698
