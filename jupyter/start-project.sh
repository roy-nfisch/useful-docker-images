#!/bin/sh
set -eu

cd /home/jovyan/work
if [ -f uv.lock ] && [ -f pyproject.toml ]; then
    echo "Installing from uv.lock."
    UV_PROJECT_ENVIRONMENT=/home/jovyan/project-env uv sync --locked
elif [ -f requirements.txt ]; then
    echo "Installing from requirements.txt."
    uv venv --allow-existing /home/jovyan/project-env
    uv pip install --python /home/jovyan/project-env/bin/python -r requirements.txt ipykernel
else
    echo "Expected pyproject.toml and uv.lock, or requirements.txt, in the project folder." >&2
    exit 1
fi

if ! /home/jovyan/project-env/bin/python -c "import ipykernel" 2>/dev/null; then
    echo "The project environment needs ipykernel. Add it to the project dependencies and update uv.lock." >&2
    exit 1
fi
/home/jovyan/project-env/bin/python -m ipykernel install --user \
  --name python3 --display-name "Python (Project)"

exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser \
  --ServerApp.root_dir=/home/jovyan/work
