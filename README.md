# Traefik environment

Https pre-configured Traefik.

## Dependencies

- [Docker](https://www.docker.com/get-started)
- [Dnsmasq](./doc/dns_config.md)
- [Mkcert](./doc/mkcert.md)

## Installation

Use init script
```bash
./script/init.sh
```

or read [manual installation doc](./doc/manual_install.md).

## Usage

```traefik-reverse-proxy``` must be started (check ```docker ps```)

**Access to Traefik dashboard:**

```traefik.REPLACE_THIS_BY_YOUR_LOCAL_DOMAIN``` on our favorite browser (it's Firefox ofc).  
(For local domain value, see [Dnsmasq](./doc/dns_config.md) doc)

Or use [localhost](localhost:8080).

**Docker-compose example:**

```yaml
# docker-compose.yaml

services:
  my-web-server:
    image: php-apache
    ports:
      - 80
      - 1773
    # Required
    networks:
      - proxy
    labels:
      # Enable Traefik
      - traefik.enable=true

      # Http access (optional. Rediction to https is enabled)
      - traefik.http.routers.my-web-server-http.entryPoints=insecure
      - traefik.http.routers.my-web-server-http.rule=Host(`my-web-server.REPLACE_THIS_BY_YOUR_LOCAL_DOMAIN`)

      # Https access
      - traefik.http.routers.my-web-server-https.entrypoints=secure
      - traefik.http.routers.my-web-server-https.rule=Host(`my-web-server.REPLACE_THIS_BY_YOUR_FUCKING_LOCAL_DOMAIN`)
      - traefik.http.routers.my-web-server-https.tls=true
        
      # Target port (optional. Needed if many port declared in service)
      - traefik.http.services.my-web-server-https.loadbalancer.server.port=1337

    /.../
    
# Required
networks:
  proxy:
    external:
      name: proxy
```
[Traefik documentation](https://docs.traefik.io/v2.2) for advanced usage.

## Know issues

**PostgresSQL:**

Can't use Traefik with postgres. I set static port instead.  
[See that](https://stackoverflow.com/questions/63354909/is-it-possible-to-use-traefik-to-proxy-postgresql-over-ssl) and [that](https://github.com/fabiolb/fabio/issues/484) for more informations.  
If you know how fix that, i'm interested :)
