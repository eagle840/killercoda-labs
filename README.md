# Killercoda Labs Collection

This repository is a collection of interactive, hands-on learning scenarios for the [Killercoda](https://killercoda.com/) platform. Each scenario provides a live terminal environment and guided instructions to help users master various technologies.

## 🚀 Overview

The labs in this repository cover a wide range of DevOps, Security, and Development tools, including:

- **Security:** OWASP ZAP (DAST), Container CVE scanning.
- **Infrastructure:** Kubernetes (1-node & 2-node), Helm, Terraform, Docker.
- **Data & Analytics:** ELK Stack, Apache Superset, Apache Drill, MLflow.
- **Development:** .NET Application Insights, ASP.NET Core, Node.js, Python.
- **Messaging:** RabbitMQ, BentoML.

## 📂 Repository Structure

Each top-level directory (e.g., `/apache_superset`, `/jenkins`) represents a standalone lab. A standard lab consists of:

- `index.json`: The main configuration file defining metadata, environment, and step order.
- `intro.md`: The landing page and introduction for the lab.
- `stepX.md`: Numbered instruction files for each hands-on step.
- `finish.md`: The concluding summary of the lab.
- `assets/`: Static files or scripts used within the lab environment.

## 🛠️ Lab Creation & Best Practices

For creators looking to contribute or improve these labs:

- **[CreatorGuide.md](./CreatorGuide.md):** A comprehensive guide on Killercoda's features, environment types, and syntax.
- **[gemini-pointers/](./gemini-pointers/):** A collection of strategic tips and best practices for planning effective, robust, and educational labs.

## 📖 Usage

To use these scenarios, link this repository to your Killercoda creator profile. Updates pushed to this repository are automatically reflected in your Killercoda labs.

---
*Created and maintained as a part of interactive technical education.*
