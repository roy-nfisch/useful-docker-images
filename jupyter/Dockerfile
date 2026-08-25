FROM quay.io/jupyter/scipy-notebook:2026-07-20

# Install GitHub Copilot support for Jupyter (notebook-intelligence)
RUN pip install --no-cache-dir notebook-intelligence

# Plotting & database libraries not included in the scipy-notebook base image
# (base already has: pandas, matplotlib, seaborn, sqlalchemy, scikit-learn)
RUN pip install --no-cache-dir plotly psycopg2-binary python-dotenv missingno nb-clean uv imbalanced-learn six pydotplus graphviz xgboost tensorflow tensorboard

EXPOSE 8888 6006

CMD ["start-notebook.py", "--NotebookApp.token=''"]
