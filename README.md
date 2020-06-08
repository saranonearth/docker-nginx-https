# docker-nginx-https
Simple docker image for nginx with https support 🔒
 
#### Build
```
docker build -t saranonearth/nginx-https .
```
#### Run the container
```
docker run -d \
-v certs:/etc/letsencrypt \
-e DOMAIN=example.com \
-e WWWDOMAIN=www.example.com \
-e EMAIL=onearth@something.com \
-p 80:80 -p 433:433 \
saranonearth/nginx-https
```
