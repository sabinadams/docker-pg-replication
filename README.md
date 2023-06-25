# Overview
This repository includes a Dockerfile and [docker-compose](https://docs.docker.com/compose/) file that provide a Postgres database configured to be compatible with [Pulse](https://www.prisma.io/data-platform/pulse).

# Usage
There are a few ways you can use this repository including:
1. Use docker-compose to spin up the database locally.
2. Use the Dockerfile and Docker CLI to run the container without docker-compose
3. Pull down the deployed version of the Dockerfile described in this repo and deploy it

You can then use a tool like [`ngrok`](https://ngrok.com/) to allow Pulse to connect to your local instance.

> **Note**
> You can also deploy the container described by the Dockerfile in this repo to some hosting provider and avoid using ngrok.

# Requirements (2)

## 1. Docker installed on your machine
You need Docker installed on your machine to build containers, run CLI commands and use docker-compose.

Follow the instructions provided by Docker's documentation to get Docker installed:

- **Mac:** https://docs.docker.com/desktop/install/mac-install/
- **Windows:** https://docs.docker.com/desktop/install/windows-install/
- **Linux:** https://docs.docker.com/desktop/install/linux-install/


## 2. ngrok installed on your machine
ngrok is used to create a publicly accessible address that exposes a processes running on your local machine. 
This is required to allow Pulse to connect to the database running on your machine. 

Follow the steps below to install ngrok:
### Mac
Run the following command in a terminal:
```sh
brew install ngrok/ngrok/ngrok
```

### Windows
Run the following command in a terminal:
```sh
winget install ngrok
```

### Linux
Run the following command in a terminal:
```sh
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | \
  sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
  echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | \
  sudo tee /etc/apt/sources.list.d/ngrok.list && \
  sudo apt update && sudo apt install ngrok
```

# Start the database server 
The first step is to clone this repository and ensure Docker is running on your system.

## _(Option #1)_ Use docker-compose to start the database server
### Start the container
Navigate into the project folder in your terminal and run this command:
```sh
docker-compose up -d
```

### Expose the database server with ngrok
Run the following command:
```sh
ngrok tcp 5432
```

## _(Option #2)_ Use the Dockerfile and run the database server via Docker CLI
### Build the container
Navigate into the project folder in your terminal and run this command:
```sh
docker build -t pulse-db-container .
```

### Run the container
Run the following command to start the container:
```sh 
docker run -d pulse-db-container -p 5432:5432
```

### Expose the database server with ngrok
Run the following command:
```sh
ngrok tcp 5432
```

## _(Option #3)_ Use the publicly available Docker image from Docker Hub
> **Note**
> You do not need to clone this repository to use this method

### Pull down the container
In your terminal, run the following command:
```sh
docker pull sabinadams/pg-pulse
```

### Run the container
Run the following command to start the container:
```sh
docker run -p 5432:5432 sabinadams/pg-pulse
```

### Expose the database server with ngrok
Run the following command:
```sh
ngrok tcp 5432
```

# Next steps
The connection string for your database will be:
```
postgresql://postgres:postgres@<url-from-ngrok>/postgres
```

To quickly get up and running with Pulse follow these steps:
1. Create a new project in Cloud Projects if you don't already have one
2. Configure Pulse, providing the connection string from above and choosing any region
3. Get an API key for your project
4. Clone the [pulse-starter](https://github.com/prisma/pulse-starter) repository and follow the steps in the README that walk you through the application-side of the setup
