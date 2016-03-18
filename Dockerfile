FROM alpine
MAINTAINER clemenko@gmail.com
LABEL VERSION="2.3.1" \
    RUN="docker run --rm -it clemenko/pdsh"

RUN apk add -U make gcc g++ perl git openssh-client && \
  adduser -S pdsh && \
  cd /tmp && git clone --branch=no-rresvport https://github.com/grondo/pdsh && \
  cd /tmp/pdsh && ./configure --without-rsh --with-ssh --with-genders && make clean && \
  make install && \
  apk del make gcc g++ perl git

CMD ["/usr/local/bin/pdsh"]
