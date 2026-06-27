# Step 4: Using the Repository

In this final step, you will create a new repository in Gitea and push your local code to it.

### 1. Create a Repository in Gitea
1. Log in to your Gitea UI.
2. Click the **+** icon in the top right corner and select **New Repository**.
3. Name your repository (e.g., `my-first-repo`).
4. Click **Create Repository**.

### 2. Configure and Push Local Code
On your terminal, initialize a new directory and push code to your new Gitea repository. Replace `<username>` and `<repo-name>` with your actual Gitea details.

```bash
mkdir my-repo && cd my-repo
git init
echo "# Hello Gitea" > README.md
git add README.md
git commit -m "Initial commit"
git branch -M main
git remote add origin git@localhost:<username>/<repo-name>.git
git push -u origin main
```{{exec}}

### 3. Verify in Gitea
Refresh your repository page in the Gitea UI. You should now see your `README.md` file listed in the repository.

Congratulations! You have successfully deployed a Gitea instance and performed a secure Git push.
