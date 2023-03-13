# Create the gitlab Project

In this specific case, we'll use a simple Node docker image to run Ghost-Blog CMS, but it could be any application compiled using dockerfile. 

project:

1. Log in to your GitLab account
1. Create a new project by selecting **Import project from > Repo by URL**
1. Add the following URL:

   ```plaintext
   https://github.com/akkireddy95/ghost-blog.git
   ```
1. Click **Create project**

This application is nothing more than Dockerfile.
The project structure is really simple, and you should consider these two resources:

- `/app/Dockerfile`: project dockerfile to generate a container image using Docker or Buildah
- `/app/config.production.json`: This file contains the Ghost Blog configuration settings for the production environment
- `/app/docker-run.sh`:  This shell script builds the Docker image and starts the Docker container.
- `/app/docker-compose.yml`: This file defines the Docker services for Ghost Blog and the MySQL database it depends on.

== How to run application - `/app/README.MD` all the steps were avaiable.

### Configure GitLab CI/CD 

Now it's time we set up [GitLab CI/CD](https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/) to automatically build and deploy the docker image!

GitLab CI/CD uses a file in the root of the repository, named `.gitlab-ci.yml`, to read the definitions for jobs
that will be executed by the configured runners. You can read more about this file in the [GitLab Documentation](https://docs.gitlab.com/ee/ci/yaml/README.md).

**By default Gitlab CI/CD will use the user credentials to push docker images to our internal registry.**


However some people prefers to deploy to **DockerHub** (not mandatory), which requires credentials set up in deployment variables.
Navigate to your project's **Settings > CI/CD > Environment variables** page for encrypted or either can user plain variables inside the `.gitlab-ci.yml`

#### Build container image using Docker and push it to registry

Docker can compile container images using DockerFile configurations.
In this section, we will explain how to build container imagens and deploy to registry using Gitlab CI.
Now it's time to define jobs in `.gitlab-ci.yml` and push it to the repository:

```yaml
stages:
  - build
  - deploy
variables:
  AWS_REGION: <your-aws-region>
  IMAGE_NAME: <your-image-name>
  ECR_REGISTRY: <your-ecr-registry>
build:
  image: docker:20.10.9
  stage: build
  script:
    - docker build -t $IMAGE_NAME .
    - docker tag $IMAGE_NAME $ECR_REGISTRY/$IMAGE_NAME
    - echo $AWS_ACCESS_KEY_ID | docker login -u AWS --password-stdin $ECR_REGISTRY
    - docker push $ECR_REGISTRY/$IMAGE_NAME
deploy:
  image: amazon/aws-cli:2.3.1
  stage: deploy
  script:
    - aws configure set region $AWS_REGION
    - aws ecs update-service --cluster <your-ecs-cluster-name> --service <your-ecs-service-name> --force-new-deployment
   only:
    - main
```

The runner uses the latest [Docker image](https://hub.docker.com/_/docker/),
which contains all of the tools and dependencies needed to manage the project
and to run the jobs.

Both `build` and `deploy` jobs leverage the `docker` command to compile the container and to deploy it to the registry configurated.
The deployment occurs only if we're pushing or merging to `master` branch, so that the development versions are tested but not published in the registry.

If the deployment has been successful, the deploy job log will output: 

```plaintext
Job succeeded
```

Done! Now you have all the changes in the GitLab repository, and a pipeline has already been started for this commit. In the **Pipelines** tab you can see what's happening.
If the deployment has been successful, the deploy job log will output:

Yay! You did it! Checking in repository will confirm that you have a new image available.
You can look in the `Packages & Registries > Container Registry`, if you have deploed to our internal Registry.
