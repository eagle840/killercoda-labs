# Step 2: Configuring Gitea

Now that the Gitea container is running, we need to perform the initial web-based configuration.

### 1. Access the Gitea UI
Gitea is running on port `3000`. Use the following link to access the Gitea setup page:

{{TRAFFIC_HOST1_3000}}

### 2. Configure Installation
On the installation page, you will need to configure the database and administrative settings.

*   **Database Type:** PostgreSQL
*   **Host:** `db:5432`
*   **Database User:** `gitea`
*   **Password:** `gitea`
*   **Database Name:** `gitea`

*   **General Settings:**
    *   **Site Title:** You can leave this as "Gitea: Git with a cup of tea".
    *   **SSH Server Domain:** `localhost`
    *   **Gitea HTTP Listen Port:** `3000`
    *   **Gitea Base URL:** `http://localhost:3000/`

*   **Administrator Account Settings:**
    *   Set up your administrator username, password, and email address.

Click **Install Gitea** to complete the process. Once installed, you will be redirected to the login page.
