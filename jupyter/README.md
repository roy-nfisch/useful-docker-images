# Jupyter for a Python project

Run one project per container, with its own Python environment.
Only the chosen project directory is mounted.

## Files

```text
jupyter/
├── .dockerignore         # Keep local files out of image builds
├── .env.example          # Project path and local port
├── .gitignore            # Keep .env out of Git
├── Dockerfile            # Jupyter base and optional full library set
├── docker-compose.yml    # Container, ports, and project storage
├── start-project.sh      # Install the project and register its kernel
└── README.md             # Setup and everyday commands
```

## 1. Choose your project

Requires Docker Compose and a project with either:

- `pyproject.toml` and `uv.lock`, including `ipykernel` in its dependencies; or
- A `requirements.txt` file. The container also installs `ipykernel`.

If both are present, the uv lock file takes priority. The image uses uv to
install dependencies and download a compatible Python version when needed.

If your uv project does not include `ipykernel`, run this from that project's
folder using uv on your computer:

```bash
uv add --dev ipykernel
```

Run these commands in your computer's terminal, from this `jupyter/` folder.
If you do not already have a `.env` file, create it:

```bash
cp .env.example .env
```

Open `.env` in your editor and set your project's absolute path and a free port:

```dotenv
TARGET_DIR=/path/to/your/project
JUPYTER_PORT=10000
```

Keep `.env` private; Git ignores it. The project path must already exist.

## 2. Open Jupyter

```bash
docker compose up -d --build
```

The first startup installs dependencies from the selected file. For uv projects,
it also installs the project package if one is defined. A requirements file is
only as reproducible as the versions it specifies.

### Log in with the token

Once Jupyter has started, get its current login token:

```bash
docker compose exec jupyter jupyter server list
```

Look for a URL containing `?token=...`. Copy only the value after `token=`,
then open `http://localhost:10000` (or your chosen port). Paste it into the
**Password or token** field and log in. The URLs in the logs show the container's
port `8888`; use your configured host port in the browser instead.

Treat the token like a password: do not commit it or share the command's output.
If the container restarts, run the command again for the current token.

In a notebook, select **Python (Project)**. If you open a Jupyter terminal,
use the project's Python explicitly:

```bash
/home/jovyan/project-env/bin/python --version
```

Plain `python` in the terminal refers to the base image, not necessarily your
project's environment.

## 3. Stop Jupyter

```bash
docker compose down
```

This stops and removes the container, keeping its dependency volumes.
After changing the path or port in `.env`, rerun the start command.

## Another project

Use a separate Compose project name and a different port to keep containers
and volumes separate:

```bash
TARGET_DIR=/path/to/another/project JUPYTER_PORT=10001 \
  docker compose -p another-project up -d --build
```

To stop that container, use the same settings and name:

```bash
TARGET_DIR=/path/to/another/project JUPYTER_PORT=10001 \
  docker compose -p another-project down
```

## If it does not start

Check `docker compose logs jupyter`. Jupyter starts only after dependency
installation and kernel setup succeed.

- **Cannot connect to Docker:** start Docker Desktop or your Docker engine.
- **Port already in use:** choose a free `JUPYTER_PORT` in `.env`, then rerun
  `docker compose up -d --build`.
- **Permission denied in the project folder:** check your folder permissions
  and Docker's file-sharing settings. The container runs as user ID 1000; on
  Linux, that user needs access to the mounted folder. Do not make the folder
  world-writable to bypass the error.

## Security

Jupyter runs as a non-root user, binds only to localhost, and requires a token.
Run only trusted notebooks: their code can modify the mounted project and
access the network. Do not publish the port beyond localhost or share tokens.
Local files are excluded from the image build context.

## Optional TensorBoard

The existing full-library Dockerfile target remains available. TensorBoard
is opt-in and uses that target:

```bash
docker compose --profile tensorboard up -d --build
```

It is available at `http://localhost:6006` and reads event files from the mounted
project folder. Your training code must write those logs; TensorBoard does not
create them.

## License

This project is licensed under the Apache License 2.0.

