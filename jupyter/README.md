# Jupyter Copilot Environment

This project provides a containerized setup to run a Jupyter Notebook environment using Docker and Docker Compose. It maps a local directory to the container so your work is saved locally.

## Prerequisites

Make sure you have the following installed on your system:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Project Structure

```text
.
|-- .env               # Your local environment variables (not tracked by git)
|-- .env.example       # Example environment variables template
|-- .gitignore         # Git ignore rules
|-- docker-compose.yml # Docker Compose configuration
|-- Dockerfile         # Docker image build instructions
|-- README.md          # Project documentation

```

## Setup

1. Clone or download this repository to your local machine.
2. Create your environment file by copying the example file:
```bash
cp .env.example .env

```


3. Open the `.env` file and update `TARGET_DIR` to the absolute path of your local project folder.

## Commands

### Start the Container

Build the image if it does not exist and start the container in the background:

```bash
docker compose up -d

```

### Get the Login Token

Jupyter requires a token for the first login. Retrieve it by checking the container logs:

```bash
docker logs jupyter

```

Look for the URL containing the token.

### Access Jupyter

Open your browser and navigate to:

```text
http://localhost:10000

```

### Stop the Container

Stop and remove the container when you are done:

```bash
docker compose down

```

## License

This project is licensed under the Apache License 2.0.

