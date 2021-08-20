# Manual install

**Config .env**

```bash
cp .env.dist .env
sed -i "" "s#CHANGE_ME#REPLACE_THIS_BY_YOUR_LOCAL_DOMAIN#g" .env
```

**Generate certificates**
```bash
mkcert -cert-file certs/default-cert.pem -key-file certs/default-key.pem "REPLACE_THIS_BY_YOUR_LOCAL_DOMAIN" "*.REPLACE_THIS_BY_YOUR_LOCAL_DOMAIN"
```

**Create docker network**
```bash
docker network create proxy
```

**Run Traefik container**

```bash
docker-compose up -d
```
