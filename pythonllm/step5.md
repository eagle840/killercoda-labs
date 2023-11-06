# Juypter notepad and lab

https://docs.jupyter.org/en/latest/


### Notebook

Jupyter Notebook is a simplified notebook authoring application, and is a part of Project Jupyter, a large umbrella project centered around the goal of providing tools (and standards) for interactive computing with computational notebooks.

`pip install notebook`{{exec}}

`jupyter notebook -h`{{exec}}

`jupyter notebook`{{copy}}

To run it on this lab:

`jupyter notebook password`{{exec}}

`jupyter notebook --allow-root --ip=0.0.0.0`{{exec}}

[click here]({{TRAFFIC_HOST1_8888}})


### Lab

JupyterLab is the next-generation user interface for Project Jupyter offering all the familiar building blocks of the classic Jupyter Notebook (notebook, terminal, text editor, file browser, rich outputs, etc.) in a flexible and powerful user interface.

`pip install jupyterlab`{{exec}}

`jupyter-lab -h`{{exec}}

`jupyter-lab`{{copy}}

To run it on this lab:

`jupyter-lab password`{{exec}}

`jupyter-lab --allow-root --ip=0.0.0.0`{{exec}}

[click here]({{TRAFFIC_HOST1_8888}})

### Voila

[Voilà](https://voila.readthedocs.io/en/stable/) allows you to convert a Jupyter Notebook into an interactive dashboard that allows you to share your work with others. It is secure and customizable, giving you control over what your readers experience.

`pip install voila`{{exec}}

`voila -h`{{exec}}

`voila`{{exec}}

WIP move pip install to top of page, an use basic for all the jupyter 

`pip install ipywidgets pandas`{{exec}}

`voila basics.ipynb --port 8888 --Voila.ip='0.0.0.0'`{{exec}}

[click here]({{TRAFFIC_HOST1_8888}})

