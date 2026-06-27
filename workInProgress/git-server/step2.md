# Step 2: Configuring Gitea

Now that the Gitea container is running, we need to perform the initial configuration.

### 1. Access the Gitea UI
Gitea is running on port `3000`. Use the following link to access the setup page:

{{TRAFFIC_HOST1_3000}}

### 2. Configure Installation Settings
On the installation page, configure the following settings:

*   **Database Type:** PostgreSQL
*   **Host:** `db:5432`
*   **Database User:** `gitea`
*   **Password:** `gitea`
*   **Database Name:** `gitea`

*   **General Settings:**
    *   **SSH Server Domain:** `localhost`
    *   **Gitea HTTP Listen Port:** `3000`
    *   **Gitea Base URL:** `http://localhost:3000/`

Click **Install Gitea** to complete the database configuration.

### 3. Register Administrator Account
After installation, you will be redirected to the login page. Since this is a new installation, you must register the first user account, which will automatically be granted administrative privileges.

Register using these example credentials:
*   **Username:** `gitea-admin`
*   **Email:** `admin@example.com`
*   **Password:** `gitea-password`

Once you have registered and logged in, you will be on the Gitea dashboard as the administrator.
