<p align="center">
    <a href="https://github.com/bubuntux/protorrent"><img src="https://raw.githubusercontent.com/bubuntux/protorrent/main/.github/header.png"/></a>
    </br>
    <a href="https://github.com/bubuntux/protorrent/blob/master/LICENSE"><img src="https://badgen.net/github/license/bubuntux/protorrent?color=cyan"/></a>
    <a href="https://hub.docker.com/r/bubuntux/protorrent/"><img src="https://badgen.net/docker/size/bubuntux/protorrent?icon=docker&label=size"/></a>
    <a href="https://hub.docker.com/r/bubuntux/protorrent/"><img src="https://badgen.net/docker/pulls/bubuntux/protorrent?icon=docker&label=pulls"/></a>
    <a href="https://hub.docker.com/r/bubuntux/protorrent/"><img src="https://badgen.net/docker/stars/bubuntux/protorrent?icon=docker&label=stars"/></a>
    <a href="https://github.com/bubuntux/protorrent"><img src="https://badgen.net/github/forks/bubuntux/protorrent?icon=github&label=forks&color=black"/></a>
    <a href="https://github.com/bubuntux/protorrent"><img src="https://badgen.net/github/stars/bubuntux/protorrent?icon=github&label=stars&color=black"/></a>
    <a href="https://github.com/bubuntux/protorrent/actions/workflows/docker-image-ci.yml"><img src="https://github.com/bubuntux/protorrent/actions/workflows/docker-image-ci.yml/badge.svg?branch=main"/></a>
</p>

# Protorrent
Proton VPN + qBtittorrent

# How to use this image
First you need to obtain the wireguard configurations from https://account.protonvpn.com/downloads: 
- Enable VPN Accelerator
- Enable NAT-PMP (Port Forwarding)
- Select a server that supports p2p.
  
Place this configuration file inside <localDir>/wireguard/

Start the container using (or equivalent)  

    docker run -d --privileged -v <localDir>:/config -p 8080:8080 ghcr.io/bubuntux/protorrent

The container is gonna be accessible only locally or through the docker network, meaning that you will need a reverse proxy like [swag](https://github.com/linuxserver/docker-swag) or [traeffik](https://doc.traefik.io/traefik/providers/docker/) to access it when not running locally.

You can also add an environment variable that would open the traffic to the specified network
    
    docker run -d --privileged -v <localDir>:/config -p 8080:8080 -e NET_LOCAL=192.168.0.0/24 ghcr.io/bubuntux/protorrent

# Environent ( -e )

|                 Variable                 |    Default     | Description |
|:-----------------------------------------|:--------------:| --- |
|                 `PUID`                |        1000    |   for UserID |
|                 `GUID`                |        1000    |   for GroupID |
|               `NET_LOCAL`               |          | CIDR networks (IE 192.168.1.0/24), add a route to allows replies once the VPN is up.
|                   `TZ`                  |               UTC             | Specify a timezone to use EG Europe/London.


# Disclaimer 
This project is independently developed for personal use, there is no affiliation with ProtonVPN, ProtonAG or qBittorrent,
ProtonAG companies are not responsible for and have no control over the nature, content and availability of this project.
