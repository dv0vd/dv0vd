FROM debian:bookworm

ARG SOCKS5_USERNAME=username
ARG SOCKS5_PASSWORD=password

ENV USERNAME=${SOCKS5_USERNAME}
ENV PASSWORD=${SOCKS5_PASSWORD}

RUN apt update
RUN apt install -y dante-server

RUN mkdir -p /etc/dante
COPY ./deployment/configs/socks5/dante.conf /etc/dante/dante.conf

RUN useradd -m "$USERNAME" && \
    echo "$USERNAME:$PASSWORD" | chpasswd && \
    adduser "$USERNAME" sudo

EXPOSE 1080

CMD ["danted", "-f", "/etc/dante/dante.conf"]