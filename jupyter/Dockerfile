FROM quay.io/jupyter/scipy-notebook:2026-07-20

# Install GitHub Copilot support for Jupyter (notebook-intelligence)
# Plotting & database libraries not included in the scipy-notebook base image
# (base already has: pandas, matplotlib, seaborn, sqlalchemy, scikit-learn)
RUN pip install --no-cache-dir \
    graphviz \
    imbalanced-learn \
    missingno \
    nb-clean \
    nltk \
    notebook-intelligence \
    plotly \
    protobuf \
    psycopg2-binary \
    pydotplus \
    python-dotenv \
    scikit-learn \
    sentencepiece \
    sentence-transformers \
    six \
    spacy \
    tensorboard \
    tensorflow \
    tensorflow_docs \
    tiktoken \
    transformers \
    uv \
    xgboost


EXPOSE 8888 6006

CMD ["start-notebook.sh", "--NotebookApp.token=''"]
