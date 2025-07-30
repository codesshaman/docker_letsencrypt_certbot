#### Clone this repo

```
https://github.com/codesshaman/docker_letsencrypt_certbot.git && cd docker_letsencrypt_certbot
```

#### Make environment file


```
make env
```

#### Make launch script

```
make script
```

Check:

```
cat /usr/local/bin/certbot-docker-renew.sh
```

#### Make systemctl service

```
make service
```

#### Make launch timer

```
make timer
```

#### First start

```
make build
```

#### Check certificates

Find your certificate in folder:

```
ls ./certs/archive/<your_domain.com>
```
