# Jupyter Docker environment

Run Jupyter with a preloaded set of data science and machine learning libraries.
Choose which local project to open; notebook changes are saved in that folder.

## Files

```text
jupyter/
├── .dockerignore         # Keep local files out of image builds
├── .env.example          # Project path and local port
├── .gitignore            # Keep .env out of Git
├── Dockerfile            # Jupyter and preinstalled libraries
├── docker-compose.yml    # Jupyter and optional TensorBoard
└── README.md             # Setup and commands
```

## 1. Choose a project

Install Docker and Docker Compose. In your computer's terminal, go to the
`jupyter/` folder. If you don't already have a `.env` file, create one:

```bash
cp .env.example .env
```

Open `.env` and set an existing project folder and a free local port:

```dotenv
TARGET_DIR=/path/to/your/project
JUPYTER_PORT=10000
```

Keep `.env` private; Git ignores it. Only the chosen folder is mounted.
The image provides shared packages, including Notebook Intelligence. It does
**not** automatically install or enforce the project's `uv.lock` or
`requirements.txt`; check the project's instructions if it needs other packages
or specific versions.

## 2. Start Jupyter

```bash
docker compose up -d --build
```

The first build downloads the image and libraries and can take a while.

### Log in

Get the current login token:

```bash
docker compose exec jupyter jupyter server list
```

Copy the value after `token=`. Open `http://localhost:10000` (or your
configured port) and paste the token into **Password or token**. The URL
printed inside the container uses port `8888`; use your configured host port
in your browser instead.

Treat the token like a password. Do not commit it or share unredacted output.
After a container restart, retrieve the current token again.

## 3. Stop Jupyter

```bash
docker compose down
```

After changing the project path or port, rerun the start command to recreate
the container with the new settings.

## Another project

To run a second container at the same time, choose another Compose project
name and a free port:

```bash
TARGET_DIR=/path/to/another/project JUPYTER_PORT=10001 \
  docker compose -p another-project up -d --build
```

Use the same settings and name to stop it:

```bash
TARGET_DIR=/path/to/another/project JUPYTER_PORT=10001 \
  docker compose -p another-project down
```

Both containers use the same image, not separate project dependency environments.

## Troubleshooting

- **Docker is unreachable:** start Docker Desktop or your Docker engine.
- **Port is in use:** choose another `JUPYTER_PORT` in `.env` and restart.
- **Permission denied in the project folder:** check folder permissions and
  Docker file-sharing settings. The container runs as user ID 1000; on Linux,
  that user needs access to the folder. Do not make it world-writable.
- **Missing package:** the image has common libraries but cannot include every
  project's dependencies. Consult the project's dependency instructions.
- **Other startup errors:** check `docker compose logs jupyter`.

## Security

Jupyter runs as a non-root user, listens only on localhost, and requires a
token. Run only trusted notebooks: their code can modify the mounted project
and access the network. Never share your token or expose Jupyter publicly
without appropriate protection.

## Optional TensorBoard

To start TensorBoard alongside Jupyter using the same image:

```bash
docker compose --profile tensorboard up -d --build
```

Open `http://localhost:6006`. TensorBoard reads event files written by your
training code into the mounted folder; it does not create them.

## License

This project is licensed under the Apache License 2.0.

