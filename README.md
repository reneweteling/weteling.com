[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)

# Weteling.com

#sldkjffdsdfls

# there is more

dokku storage:mount weteling /home/dokku/weteling/static/assets:/var/www/html/public/assets
dokku storage:mount weteling /home/dokku/weteling/static/packs:/var/www/html/public/packs

## /home/dokku/weteling/nginx.conf.d/static.conf

```conf

location ~ ^/assets|packs/ {
    root /home/dokku/weteling/static;
    gzip_static on;
    expires max;
    add_header Cache-Control public;
}
```


## DB config

scp root@weteling.com:weteling.dump .
pg_restore --no-privileges --no-owner --host localhost --dbname weteling-dev weteling.dump