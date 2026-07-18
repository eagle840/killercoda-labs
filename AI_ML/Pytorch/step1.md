## Install Directly in Lab

# Initial Setup




{{TRAFFIC_HOST1_8888}}

--- 

## Run from Docker


The Dockerfile is included as a lab asset at `assets/Dockerfile`.




A fast‑starting, small Docker container for **CPU‑only PyTorch + Jupyter Notebook** is absolutely doable — and you don’t need the heavyweight official PyTorch images to get there. The trick is to start from a **minimal base**, install only what you need, and avoid CUDA‑related packages.

**Short answer:**  
Use a slim Python base image, install CPU‑only PyTorch wheels directly from PyPI, add JupyterLab, expose port 8888, and keep everything cached minimally.

---

## 🚀 The container you actually want  
A **small, fast-pulling, CPU-only PyTorch + Jupyter** environment built on `python:3.x-slim`.

Below is a Dockerfile that hits your goals:

`cat Dockerfile`{{exec}}

This image typically ends up around **300–400 MB**, which is *tiny* compared to the official PyTorch images (often 3–5 GB).

---

## 🧠 Why this approach is fast and small  
- **python:slim** avoids unnecessary OS packages.  
- **CPU-only PyTorch wheels** are much smaller than CUDA builds.  
- **No conda** — pip + slim base keeps things lightweight.  
- **No extra libraries** unless you add them.  
- **No cache** (`--no-cache-dir`) keeps layers small.

---

## 📊 What you can do inside this container  
- Run **JupyterLab** in your browser  
- Train **small CPU-only PyTorch models**  
- Use **torchvision** transforms and datasets  
- Add your own notebooks under `/workspace`

Here’s what the environment looks like visually:





---

## 🧪 Example: Running the container  
Build:

```bash
docker build -t pytorch-cpu-jupyter .
```{{exec}}

Run:

```bash
docker run -it -p 8888:8888 -v $(pwd):/workspace pytorch-cpu-jupyter
```{{exec}}

Then copy te key from the output, open:

{{TRAFFIC_HOST1_8888}}

---

## 🔧 Optional upgrades (all small footprint)
- **Add NumPy**  
- **Add Matplotlib**  
- **Add notebook extensions**  
- **Switch to Jupyter Notebook instead of Lab**  
- **Add a non-root user**  

---

## 🧩 Want an even smaller image?  
You can go ultra-minimal by using **python:alpine**, but PyTorch wheels do not support Alpine’s musl libc. So the slim Debian base is the smallest practical option.

If you want, I can help you build a **multi-stage Dockerfile** that trims the image even further.

---

## 👉 What do you want next?  
Choose one and I’ll build it for you:

- **Make the image even smaller**  
- **Add sample PyTorch training notebooks**  
- **Add VS Code server instead of Jupyter**  
- **Add data science libraries**


### 1. The Beginner-Friendly Giant: **mrdbourke/pytorch-deep-learning**

Created by Daniel Bourke for his "Zero to Mastery" course, this repository is organized strictly around structured, highly annotated Jupyter notebooks. It starts from complete scratch (tensors) and builds up to computer vision and custom datasets.

* **Best for:** Step-by-step learning with highly commented, easy-to-read notebooks.
* **Topics covered:** Fundamentals, Workflow, Classification, Computer Vision, Custom Datasets, and Transfer Learning.
* **GitHub Link:** [https://github.com/mrdbourke/pytorch-deep-learning](https://github.com/mrdbourke/pytorch-deep-learning)

`git clone https://github.com/mrdbourke/pytorch-deep-learning`{{exec}}

---

### 2. Bite-Sized Practice: **dair-ai/pytorch_notebooks**

This repository is a curated collection of standalone notebooks. It doesn't throw a massive curriculum at you; instead, it provides clean, independent notebook files for studying specific tasks.

* **Best for:** Picking and choosing specific topics without installing a massive project structure.
* **Topics covered:** Simple regression, CNN quickstarts, RNNs, and basic NLP.
* **GitHub Link:** [https://github.com/dair-ai/pytorch_notebooks](https://github.com/dair-ai/pytorch_notebooks)


`git clone https://github.com/dair-ai/pytorch_notebooks`{{exec}}

## Install and run Jupyter

`pip install jupyter`{{execute}}

`jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root`{{execute}}