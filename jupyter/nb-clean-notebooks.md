# Cleaning Jupyter Notebooks

Before committing any `.ipynb` file, strip its outputs and metadata using [`nb-clean`](https://github.com/srstevenson/nb-clean).

## Install

```bash
pip install nb-clean
```

## Clean a notebook

```bash
nb-clean clean --remove-all-notebook-metadata notebook.ipynb
```

This removes cell outputs, execution counts, cell metadata, and notebook-level metadata (kernel spec, language version, etc.), and cleans the file in place.

## Clean all notebooks in the project

```bash
nb-clean clean --remove-all-notebook-metadata .
```

## Optional: automate on every commit

Run once per clone to have Git clean notebooks automatically when staged:

```bash
nb-clean add-filter --remove-all-notebook-metadata
```

To remove the filter later:

```bash
nb-clean remove-filter
```
