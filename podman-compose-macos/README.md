# Podman Compose POC

> This was done on MacOS 

Based on https://github.com/diegopacheco/devops-playground/tree/master/podman-docker-compose-simple

## Steps

* Install podman compose

```bash
brew install podman-compose
```

* Run containers
```bash
podman-compose up
```

* Access the app via http://localhost:3000/

* Stop containers
```bash
podman-compose down
```

* List containers
```bash
podman ps -a
```

* Delete containers
```bash
podman container rm $id
```