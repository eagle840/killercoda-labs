# Step 3: SSH Key Authentication

To perform Git operations securely via SSH, we need to generate an SSH key pair and add it to your Gitea account.

### 1. Generate SSH Keys
On the terminal, generate a new SSH key pair:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com" -N "" -f ~/.ssh/id_ed25519
```{{exec}}

### 2. Copy the Public Key
Display your public key and copy it to your clipboard:

```bash
cat ~/.ssh/id_ed25519.pub
```{{exec}}

### 3. Add Key to Gitea
1. Log in to your Gitea instance via the web UI.
2. Click on your profile icon in the top right corner and select **Settings**.
3. Go to the **SSH / GPG Keys** tab.
4. Click **Add Key**.
5. Paste your public key into the **Content** field and give it a title (e.g., "my-ssh-key").
6. Click **Add Key** to save it.

Now your machine is authorized to communicate with the Gitea server over SSH.
