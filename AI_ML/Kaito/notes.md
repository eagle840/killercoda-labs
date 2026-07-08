Building a Kaito Killcoda Lab
https://gemini.google.com/share/3580167d03b2
Created with 3.1 Flash-Lite July 8, 2026 at 02:20 PM
Published July 8, 2026 at 02:31 PM
I'm interested in creating a Killcoda lab for the AI operator Kaito. I have basic knowledge of k8s, and using helm charts, and starting to learn about neural networks. Help me go through the process of creating the lab. Can you ask questions if you need to.

Creating a Killcoda lab for KAITO (Kubernetes AI Toolchain Operator) is a fantastic project. Because KAITO simplifies the complex task of running AI models (inference and tuning) on Kubernetes by automating infrastructure provisioning and model lifecycle management, it makes for an excellent educational scenario.

To create an effective lab, you need to structure it around the "Day 0 to Day 2" experience of a Kubernetes administrator.

The Logical Flow of a Kaito Lab
A good lab usually follows a progressive path. I suggest this structure:

Introduction: What is KAITO, and why does it matter? (The problem of managing GPU nodes and large model images).

Environment Setup: Ensuring the environment has the necessary K8s context and KAITO CRDs (Custom Resource Definitions) installed.

Deploying a Model (Inference): Using a simple Workspace manifest to deploy a lightweight model (e.g., phi-3-mini or a similar CPU-friendly model if GPUs are limited in the lab).

Verification: Checking the logs, the inference endpoint, and the auto-provisioned nodes.

Clean up: Deleting the Workspace and observing the operator tear down the resources.

Key Technical Concepts to Cover
Since you are familiar with Helm and basic K8s, lean into these KAITO-specific components:

Workspace CRD: This is the core of KAITO. You define the model and compute requirements, and the controller handles the rest.  
GitHub

InferenceSet & InferencePool: For scaling and routing.

Node Auto-Provisioning (NAP): Explain that KAITO often integrates with tools like Karpenter to dynamically request GPU nodes.  
Indrajith Ekanayake

Presets: Highlight how KAITO includes pre-configured settings for popular models (Llama, Mistral, Phi), removing the need for users to write complex deployment specs.

Steps to Build Your Lab
Draft the foreground script: Killcoda labs use a foreground script to set up the environment. You will need to write a script that installs the KAITO Helm chart onto the provisioned K8s cluster.

Create Documentation: Use Markdown files in the Killcoda repository structure. Focus on "Step-by-Step" instructions where the user must kubectl apply -f a specific YAML file you provide.

Interactive Elements: Use Killcoda's "Verify" feature to ensure the user has actually created the resources before moving to the next step.

Let's Collaborate on the Details
To help you build this out effectively, I need a little more clarity on the scope:

Do you want the lab to focus specifically on "Inference" (running the model) or "Tuning" (customizing the model with data)? Inference is much more straightforward for a first lab.

Do you have a specific target audience in mind (e.g., complete Kubernetes beginners, or experienced DevOps engineers looking to add AI to their clusters)? This dictates how much "hand-holding" the text should provide.

Which direction would you like to take for the first module?

1: its many so users (including myself) can learn fine tuning. and 2: the user should understand basic k8s usage and concentrate on getting the fine tuning working and then creating an inference. Of course, its best to use as small as model as possible, but close to LLM's so the user can understand whats involved to fine tuning LLM's, with out have to deal with the large model size and compute cost.

This is a great, focused approach. Since you want to emphasize fine-tuning and inference as a DevOps workflow, we should structure this as a "Model Lifecycle in Kubernetes" lab.

Using KAITO to handle the heavy lifting (like node provisioning and container wrapping) is the perfect way to allow a learner to focus on the process of fine-tuning rather than the plumbing of GPU drivers.

Recommended Lab Scope: "The LLM Fine-Tuning Pipeline"
To keep compute costs low and pedagogical value high, I recommend using Phi-3-mini (3.8B). It is small enough to be nimble but is a fully functional LLM capable of showing real, measurable fine-tuning results.

The Lab Roadmap (Proposed)
Stage	Objective	Learner Action
1. Prep	Get the playground ready.	Deploy KAITO Helm chart to the K8s cluster.
2. Baseline	Test base performance.	Deploy an Inference Workspace for base Phi-3-mini; query it.
3. Fine-Tune	Modify the model.	Deploy a Tuning Workspace with a small custom dataset; wait for it to produce an "Adapter" (LoRA).
4. Inference	Deploy fine-tuned model.	Create a new Workspace that points to the base model + your new adapter; query it to see the change.
5. Cleanup	Manage costs.	Delete workspaces and release GPU resources.
Technical Approach for Fine-Tuning
To ensure this is manageable for you and other users:

Parameter-Efficient Fine-Tuning (PEFT/LoRA): We will focus on LoRA (Low-Rank Adaptation). Instead of tuning the entire 3.8 billion parameters, we only tune a tiny fraction. This is why it is possible to do this on a single, reasonably sized GPU node rather than a massive cluster.

Data Input: Use a simple, hosted JSONL file (e.g., hosted on a public GitHub Gist or a small storage bucket) so the user doesn't have to worry about data pipelines.

Outcome: The "success" state is getting the model to respond in a slightly different format or style (e.g., forcing it to answer like a pirate or in a specific JSON structure) to prove the fine-tuning worked.

My Questions to Guide You Further
To get this into a "Ready to Build" state, I need to know a few details about your constraints:

What is the underlying Kubernetes infrastructure for this Killcoda lab? Does the environment provide access to actual GPU-backed nodes (like Standard_NC series in Azure or g4dn in AWS), or are you planning to use a "mock" GPU driver for the lab? Note: True fine-tuning requires real GPU memory (VRAM). If you don't have access to real GPUs, we may need to use a "Simulation" mode in the lab.

How comfortable are you with YAML manifests? KAITO relies heavily on CRDs (Custom Resource Definitions). I can help draft the Workspace templates, but I want to know if you'd prefer to learn the kubectl CLI commands or the structural setup of the YAMLs themselves.

Are you planning to build this using the Killcoda foreground script method? This is the most professional way to automate the setup of the K8s cluster and KAITO operator so that when a user clicks "Start," everything is waiting for them.

What is your preference regarding the GPU access—are we working with real hardware, or are we simulating the workflow?

Killacoda doesn't offer GPU's ot TPU, only CPU, Should I select a single node k8s or 2 node (the only options). we will not use a foreground or start up script. And it sounds like we should use kubectl - but I'm not sure

Since you are working within a CPU-only Killcoda environment, we have a unique challenge. You cannot perform "real" fine-tuning on a CPU without it being excruciatingly slow or outright crashing (most fine-tuning frameworks like KAITO/vLLM/PyTorch explicitly look for CUDA/GPU devices).

However, since this is for learning the workflow, we can use a "Simulation/Mock" pattern. The goal is for you and your students to learn the Kubernetes orchestration of AI: installing operators, managing custom resources, mounting volumes, and checking logs.

1. Cluster Selection
Select the 2-node cluster. * Why: You need one node for your "Control Plane/Management" (running KAITO, kubectl, and monitoring tools) and one node for your "Worker/Workload" (where you will attempt to run the simulated fine-tuning/inference). This gives you the most realistic environment for testing how pods schedule and communicate.

2. Strategy: The "Simulated" Fine-Tuning Lab
Since you cannot run GPU training, you will create a lab that teaches the steps without requiring the hardware.

The "Mock" Fine-Tune: Create a Kubernetes Job or a custom Workspace manifest that runs a lightweight script (e.g., a simple Python script). Instead of actually doing math-heavy matrix multiplication, the script will:

Sleep for a minute (simulating "loading model").

Write a dummy file (adapter_model.bin) to a shared Persistent Volume (PV).

Exit with a "Success" status.

The Lesson: The student learns how to use kubectl apply to submit a Workspace manifest, how to wait for the Job to complete, how to check kubectl logs, and how to inspect the generated "model" artifact on a volume.

3. Why kubectl is the right choice
For a lab focusing on AI operators, kubectl is the standard.

It teaches the student how to interact with the KAITO CRDs (kubectl get workspaces, kubectl describe workspace <name>).

It forces them to understand the status conditions of a resource, which is the most important skill for an AI operator administrator (e.g., "Why is my model stuck in Pending?").

Revised Lab Plan for CPU-Only
Step	Action	Learner Goal
1. The Operator	helm install kaito	Understand how operators extend K8s.
2. The Baseline	Deploy a tiny CPU inference container.	Understand service exposure and API ports.
3. The Tuning	Apply a Workspace manifest that points to a "mock" fine-tuning image.	Learn the Workspace CRD and Persistent Volumes.
4. The Merge	Point a second Workspace to the "fine-tuned" adapter.	Learn how model weights/adapters are referenced.
