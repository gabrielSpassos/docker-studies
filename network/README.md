# Docker user-defined bridge network

* Create Network

```
docker network create my-bridge-net
```

* Connect container to Network

```
docker create --name my-tomcat \
  --network my-bridge-net \
  --publish 8080:8080 \
  tomcat:latest
```

* Run container

```
docker run -p 8080:8080 tomcat
```
