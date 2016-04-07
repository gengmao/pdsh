FROM alpine
MAINTAINER clemenko@gmail.com
LABEL VERSION="2.3.1" \
    RUN="docker run --rm -it -v $HOME/.ssh/:/home/pdsh/.ssh/ clemenko/pdsh"

RUN apk add -U make gcc g++ perl git openssh-client && \
  addgroup -g 1000 pdsh && adduser -G pdsh -u 1000 -S pdsh && \
  cd /tmp && git clone --branch=no-rresvport https://github.com/grondo/pdsh && \
  cd /tmp/pdsh && ./configure --without-rsh --with-ssh --with-genders && make clean && \
  make install && \
  apk del make gcc g++ perl git && \
  rm -rf /var/cache/apk/* /tmp/pdsh

USER pdsh
WORKDIR /home/pdsh

ENTRYPOINT ["/usr/local/bin/pdsh"]
