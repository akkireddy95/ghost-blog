# Build the Docker image
docker build -t ghost .

# Run the Docker container
docker run -p 2368:2368 -d ghost
