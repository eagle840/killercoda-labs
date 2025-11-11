Here’s a condensed **Markdown document** summarizing the key points from the Killercoda web page:
# Killercoda Creator Guide

## 🚀 Getting Started
- **Become a Creator**: Create interactive scenarios for teaching, sharing, or presenting on a Ubuntu Server(s)
- **Setup**:
  - Link a GitHub repo to your Killercoda profile.
  - Push updates to the repo/branch to update scenarios.
  - Use JSON, Markdown, and Bash.

## 🖥️ Environments
| Name | Description | Memory |
|------|-------------|--------|
| `ubuntu` | Ubuntu 24.04 with Docker & Podman | 2GB |
| `ubuntu-4GB` | Same as above | 4GB |
| `kubernetes-kubeadm-1node` | 1 controlplane, taint removed | 2GB |
| `kubernetes-kubeadm-2nodes` | 1 controlplane + 1 node | 4GB |

### Kubernetes Release Cycle
| Environment | Before 2025-07-15 | From 2025-07-15 |
|-------------|-------------------|-----------------|
| `kubeadm-1node` | 1.32 | 1.33 |
| `kubeadm-2nodes` | 1.32 | 1.33 |
| `rapid` versions | 1.33 | 1.33 |

## 📚 Scenario Examples
- **Simple Ubuntu**:
```json
{ "title": "Ubuntu simple", "backend": { "imageid": "ubuntu" } }
```
- **Kubernetes Multi-Step**:
```json
{
  "title": "Kubernetes 2node multi-step verification",
  "details": {
    "intro": { "text": "intro.md" },
    "steps": [
      { "title": "Create a pod", "text": "step1/text.md", "verify": "step1/verify.sh" },
      { "title": "Delete a pod", "text": "step2/text.md", "verify": "step2/verify.sh" }
    ],
    "finish": { "text": "finish.md" }
  },
  "backend": { "imageid": "kubernetes-kubeadm-2nodes" }
}
```

## 🧑‍💻 Visual Editor (IDE)
- Use **Theia IDE** by default:
```json
{
  "title": "Use Theia by default",
  "backend": { "imageid": "ubuntu" },
  "interface": { "layout": "ide" }
}
```

## 📦 Courses (Scenario Groups)
- Group scenarios via subdirectories or `structure.json`.
- `structure.json` controls:
  - Sort order
  - Cross-course references
  - Title/description overrides
  - Directory exclusions

## 🔧 Custom Code Actions
- Copyable: `` `copy me` ``
- Executable: `` `ls -lh`{{exec}} ``
- With interrupt: `` `whoami`{{exec interrupt}} ``
- Multiline:
```bash
kubectl get pod
kubectl get ns
```{{copy}}

## 🌐 Network Traffic
- Use HTTP (not HTTPS).
- Markdown variables:
  - `{{TRAFFIC_SELECTOR}}`
  - `{{TRAFFIC_HOST1_80}}`
  - `{{TRAFFIC_HOSTX_Y}}`
- Bash example:
```bash
sed 's/PORT/80/g' /etc/killercoda/host
```

## 🖧 Host IPs
| Host | IP |
|------|----|
| host1 | 172.30.1.2 |
| host2 | 172.30.2.2 |
| host3 | 172.30.3.2 |

## 🛠️ Scripts
- **Foreground**: visible to user.
- **Background**: hidden from user.
- Combine both for setup.
- Debug errors via Creator Debug Section.

## ⏱️ Scenario Lifetimes
| Membership | Max Time | Concurrent Scenarios |
|------------|----------|----------------------|
| FREE | 1 hour | 1 |
| PLUS | 4 hours | 3 |

## 📊 Activity Insights
- View usage stats for last 6 months.

## 🔁 Migration from Katacoda
- Compatible format.
- Migration guide available.

---

Created from the Killacoda site.

---

**A Killercoda lab typically follows a structured GitHub repository format with key files like `index.json`, `intro.md`, `step*.md`, and `finish.md` to define the tutorial flow.**

Here’s a breakdown of the standard Killercoda lab file structure and what each component does:

---

### 🗂️ **Core File Structure**

| File/Folder       | Purpose                                                                 |
|-------------------|-------------------------------------------------------------------------|
| `index.json`      | Defines the scenario metadata, environment, and steps.                  |
| `intro.md`        | Introduction shown before the lab starts.                              |
| `step1.md`, `step2.md`, etc. | Markdown files for each step in the lab.                        |
| `finish.md`       | Final message shown after lab completion.                              |
| `setup`           | Optional folder for initialization scripts or files.                   |
| `assets/`         | Static files like images or code snippets used in the lab.             |
| `.gitignore`      | Git configuration to exclude unnecessary files.                        |
| `README.md`       | Overview of the lab repository for contributors.                       |

---

### 🧩 **Optional Enhancements**

- **`structure.json`**: Used in advanced setups to define nested tutorials or product-specific flows.
- **`scripts/`**: Contains shell scripts or automation used during lab setup.
- **`tools/`**: Custom utilities or binaries used in the lab.
- **`docs/`**: Additional documentation or transformer tool references (especially in Grafana’s Killercoda setups).

---


