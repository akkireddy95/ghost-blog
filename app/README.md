# Ghost Blog Platform
This is a simple Ghost Blog application built using the Ghost CMS and MySQL database.

## Requirements
- Docker
- Docker Compose

### Getting Started
1. Clone the repository

```shell
git clone https://github.com/akkireddy95/ghost-blog.git
```

2. Navigate into the project directory:

```shell
cd ghost-blog/app
```

3. Run the following command to start the application with docker build locally

```shell
docker build -f Dockerfile -t ghost:latest .
docker run -d -p 5000:5000 ghost
```

or

Run the automated script file `docker-run.sh`, and make it executable with `chmod +x run-docker.sh`. Then you can run the script with `./run-docker.sh`.

4. Either we can following command to start the application with docker-compose

```shell
docker-compose up --build -d
```
