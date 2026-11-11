FROM quay.io/jupyter/scipy-notebook:python-3.13.17

# Install GitHub Copilot support for Jupyter (notebook-intelligence)
# Plotting & database libraries not included in the scipy-notebook base image
# (base already has: pandas, matplotlib, seaborn, sqlalchemy, scikit-learn)
# Install PyTorch from the CPU index first, then keep that version when
# resolving the rest of the libraries.
RUN pip install --no-cache-dir --index-url https://download.pytorch.org/whl/cpu torch && \
    pip freeze | grep '^torch==' > /tmp/torch-constraint.txt

RUN pip install --no-cache-dir --constraint /tmp/torch-constraint.txt \
    duckdb \
    'datasets>=5.0.1' \
    'great-expectations>=1.23.0' \
    'certifi>=2026.10.19' \
    'click>=8.5.0' \
    'fastapi>=0.141.1,<0.155' \
    'httpx2>=2.13.0' \
    'ipykernel>=7.3.0' \
    'ipywidgets>=8.1.9' \
    'joblib>=1.6.0' \
    'matplotlib>=3.11.2' \
    'mlflow>=3.16.1' \
    'nbformat>=5.11.1' \
    'numpy>=2.5.3' \
    'pandas>=3.0.6' \
    'pip>=26.2.2' \
    'prefect>=3.8.6' \
    'pyarrow>=25.0.1' \
    'pytest>=9.1.1' \
    'scipy>=1.18.1' \
    'uvicorn[standard]>=0.53.0' \
    graphviz \
    langchain \
    langchain_chroma \
    langchain_classic \
    langchain_huggingface \
    langchain_mcp_adapters \
    imbalanced-learn \
    markitdown[all] \
    markitdown \
    missingno \
    nb-clean \
    nltk \
    notebook-intelligence \
    openai \
    'optuna>=5.0.0' \
    'plotly>=7.1.0' \
    protobuf \
    'psycopg2-binary>=2.9.13' \
    pypdf \
    pydotplus \
    'python-dotenv>=1.2.3' \
    rasterio \
    'scikit-learn>=1.9.1' \
    sentencepiece \
    sentence-transformers \
    six \
    'skops>=0.15.0' \
    spacy \
    surprise \
    tensorboard \
    tensorflow \
    tensorflow_docs \
    tiktoken \
    transformers \
    'uv>=0.13.5' \
    'wordcloud>=1.9.6' \
    xgboost-cpu && \
    python -c 'import torch; assert torch.version.cuda is None, "Expected CPU-only PyTorch"'


EXPOSE 8888 6006

# Keep Jupyter's default generated-token authentication enabled.
CMD ["start-notebook.sh"]
