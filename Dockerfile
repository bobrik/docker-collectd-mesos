FROM gliderlabs/alpine:3.1

RUN apk-install collectd collectd-python py-pip && \
    pip install envtpl

ADD collectd.conf.tpl /etc/collectd/collectd.conf.tpl

RUN apk-install git && \
    git clone https://github.com/rayrod2030/collectd-mesos.git /usr/share/collectd/plugins/mesos && \
    apk del git

ADD ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
