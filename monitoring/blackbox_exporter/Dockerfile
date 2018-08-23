FROM        prom/blackbox-exporter:latest
#FROM golang:latest

COPY blackbox.yml       /etc/blackbox_exporter/config.yml

#RUN wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.12.0/blackbox_exporter-0.12.0.linux-amd64.tar.gz \
#    && tar -xzvf blackbox_exporter-0.12.0.linux-amd64.tar.gz \
#    && mv blackbox_exporter-0.12.0.linux-amd64/blackbox_exporter /bin \
#    && rm -rf blackbox_exporter-0*

EXPOSE      9115
ENTRYPOINT  [ "/bin/blackbox_exporter" ]
CMD         [ "--config.file=/etc/blackbox_exporter/config.yml" ]

