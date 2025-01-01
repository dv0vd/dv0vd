FROM debian:bookworm

RUN apt update
RUN apt install -y dante-server

RUN mkdir -p /etc/dante
COPY ./deployment/configs/socks4/dante.conf /etc/dante/dante.conf

EXPOSE 1080

CMD ["danted", "-f", "/etc/dante/dante.conf"]