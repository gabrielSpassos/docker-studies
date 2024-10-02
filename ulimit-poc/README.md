# Ulimit POC

### Usage

__default ulimit__

```bash
docker run -it ubuntu
```

```bash
root@6b6158329d9b:/# ulimit -n
1048576
```

----

__custom ulimit__

```bash
docker run --ulimit nofile=2000:2000 -it ubuntu
```

```bash
root@b8c8cbc2fa89:/# ulimit -n
2000
```

### Usage with dockerfile

```bash
docker build -t ulimit-poc .
```

```bash
docker images
```

```
REPOSITORY                TAG         IMAGE ID      CREATED         SIZE
localhost/ulimit-poc      latest      887c4efbe6b7  36 seconds ago  155 MB
```

```bash
docker run -it --name=ulimit-poc_container_name ulimit-poc /bin/bash
```

```bash
root@c2e9b5659300:/# ulimit -n
1048576
```