## Install Directly in Lab

# Initial Setup

!Please be warned, the install time for the packages in this lab can take some time!

https://docs.trychroma.com/getting-started

Installing Chromadb and be a bit of a pain, but the following sequence successfully installs on this version of Ubuntu.

`apt update`{{exec}}

`sudo apt-get install libreadline-dev -y`{{exec}}

## Setup Python

`python -V`{{exec}}

`apt install -y python3.12-venv`{{exec}}

`cd ~`{{exec}}

`mkdir vector`{{exec}}

`cd vector/`{{exec}}

```bash
python3.12 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
```{{exec}}


```bash
pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cpu
```{{exec}}




Consider the following git repos

You are completely right—the official PyTorch tutorials repository is absolutely massive because it is designed to build the entire documentation website (complete with Sphinx configs, heavy assets, and web-hosting bloat).

If you just want clean, lightweight, and straightforward Jupyter notebooks that you can clone and run locally right away, there are several highly-regarded, community-maintained alternatives:

---

### 1. The Classic Minimalist: **yunjey/pytorch-tutorial**

This is one of the most popular community repositories for PyTorch. It is incredibly lightweight and focuses on keeping things as simple as possible—most models are implemented in fewer than 30 lines of code.

* **Best for:** Quick reference, clean code, and fast cloning.
* **Topics covered:** PyTorch basics, Linear/Logistic Regression, Feedforward Nets, CNNs, RNNs, GANs, and Style Transfer.
* **GitHub Link:** [https://github.com/yunjey/pytorch-tutorial](https://github.com/yunjey/pytorch-tutorial)

`git clone https://github.com/yunjey/pytorch-tutorial`{{exec}}



---

### 2. The Beginner-Friendly Giant: **mrdbourke/pytorch-deep-learning**

Created by Daniel Bourke for his "Zero to Mastery" course, this repository is organized strictly around structured, highly annotated Jupyter notebooks. It starts from complete scratch (tensors) and builds up to computer vision and custom datasets.

* **Best for:** Step-by-step learning with highly commented, easy-to-read notebooks.
* **Topics covered:** Fundamentals, Workflow, Classification, Computer Vision, Custom Datasets, and Transfer Learning.
* **GitHub Link:** [https://github.com/mrdbourke/pytorch-deep-learning](https://github.com/mrdbourke/pytorch-deep-learning)

`git clone https://github.com/mrdbourke/pytorch-deep-learning`{{exec}}

---

### 3. Bite-Sized Practice: **dair-ai/pytorch_notebooks**

This repository is a curated collection of standalone notebooks. It doesn't throw a massive curriculum at you; instead, it provides clean, independent notebook files for studying specific tasks.

* **Best for:** Picking and choosing specific topics without installing a massive project structure.
* **Topics covered:** Simple regression, CNN quickstarts, RNNs, and basic NLP.
* **GitHub Link:** [https://github.com/dair-ai/pytorch_notebooks](https://github.com/dair-ai/pytorch_notebooks)


`git clone https://github.com/dair-ai/pytorch_notebooks`{{exec}}

## Install and run Jupyter

`pip install jupyter`{{execute}}

`jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root`{{execute}}



copy the token from the output to connect to the webserver


connect to port 8888

{{TRAFFIC_HOST1_8888}}