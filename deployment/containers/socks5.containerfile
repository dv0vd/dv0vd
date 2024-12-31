FROM debian:bookworm

ARG SOCKS5_USERNAME=username
ARG SOCKS5_PASSWORD=password

ENV USERNAME=${SOCKS5_USERNAME}
ENV PASSWORD=${SOCKS5_PASSWORD}

# Prevent services from starting during installation
# RUN echo '#!/bin/sh' > /usr/sbin/policy-rc.d && \
#     echo 'exit 101' >> /usr/sbin/policy-rc.d && \
#     chmod +x /usr/sbin/policy-rc.d

# Set DEBIAN_FRONTEND to noninteractive
# ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y dante-server

RUN mkdir -p /etc/dante
COPY ./deployment/configs/dante/dante.conf /etc/dante/dante.conf

RUN useradd -m "$USERNAME" && \
    echo "$USERNAME:$PASSWORD" | chpasswd && \
    adduser "$USERNAME" sudo

EXPOSE 1080

CMD ["danted", "-f", "/etc/dante/dante.conf"]


# Use an official Debian image as a base
# FROM debian:bullseye

# # Install dante-server
# RUN apt-get update && \
#     apt-get install -y dante-server && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# # Copy the custom configuration file
# COPY dante.conf /etc/danted.conf

# # Expose the SOCKS5 port
# EXPOSE 1080

# # Start the dante-server
# CMD ["danted", "-f", "/etc/danted.conf"]