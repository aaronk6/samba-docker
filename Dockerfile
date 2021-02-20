FROM ubuntu:20.04

ENV samba_version=4.13.4
ENV bootstrap=https://git.samba.org/?p=samba.git;a=blob_plain;f=bootstrap/generated-dists/ubuntu2004/bootstrap.sh;hb=v4-13-test

# Install build dependencies
RUN apt-get update && apt-get install -y curl && curl -s "${bootstrap}" | bash

RUN curl -s https://download.samba.org/pub/samba/stable/samba-${samba_version}.tar.gz -o samba.tar.gz \
    && tar xfz samba.tar.gz

RUN cd samba-${samba_version} && \
    ./configure

RUN cd samba-${samba_version} && \
    make && make install

RUN apt-get -y remove curl && apt-get -y autoremove

VOLUME [ "/mnt/storage", "/usr/local/samba/etc" ]

CMD [ "/usr/local/samba/sbin/smbd", "--log-stdout", "--foreground", "--no-process-group" ]
