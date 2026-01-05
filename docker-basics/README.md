# Docker Repo

### Docker Tutorial 

You can see it all on this [link](https://docs.docker.com/get-started/)

* To install go to this [link](https://docs.docker.com/install/)

* Then try this:

```
docker --version
```

```
docker run hello-world
```

* Now try this: 

```
docker build -t friendlyhello .
```

```
docker run -p 4000:80 friendlyhello
```

_The internal port of the container is 80 and the **external** is 4000_

* Go to your browser at [http://localhost:4000](http://localhost:4000)

* Run the app in background 

```
docker run -d -p 4000:80 friendlyhello
```

* Kill the container with:

```
docker container ls

```

```
docker container stop ${CONTAINER ID}

```

* You can run directly from [DockerHub](https://hub.docker.com/u/gabrielpassos/) with: 
```
docker run -p 4000:80 gabrielpassos/get-started:part2
```
