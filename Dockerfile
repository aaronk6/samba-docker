FROM debian:buster

ENV samba_version=4.13.4
ENV bootstrap=https://git.samba.org/?p=samba.git;a=blob_plain;f=bootstrap/generated-dists/debian10/bootstrap.sh;hb=v4-13-test
ENV download_url=https://download.samba.org/pub/samba/stable/samba-${samba_version}.tar.gz
ENV workdir=/root

WORKDIR ${workdir}

ADD ${bootstrap} bootstrap.sh
ADD ${download_url} samba.tar.gz

RUN chmod +x bootstrap.sh && \
    ./bootstrap.sh && \
    tar xfz samba.tar.gz && \
    cd samba-${samba_version} && \
    ./configure && make -j 4 && make install && \
    # FIXME: I'm sure there is more we can remove, but what is an easy way to find out?
    apt-get -y -q remove curl wget htop git build-essential autoconf *-dev && \
    cd ${workdir} && \
    rm -rf bootstrap.sh samba.tar.gz samba-${samba_version}

VOLUME [ "/mnt/storage", "/usr/local/samba/etc" ]

CMD [ "/usr/local/samba/sbin/smbd", "--log-stdout", "--foreground", "--no-process-group" ]
