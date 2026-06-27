# Step 1: Deploying the Git Server

In this step, we will use Docker Compose to deploy Gitea and its required database (Postgres).

### 1. View the Compose Configuration
First, take a look at the provided `docker-compose.yml` file to understand the services being deployed.

```bash
cat docker-compose.yml
```{{exec}}

### 2. Launch the Services
Start Gitea and the database in detached mode:

```bash
docker-compose up -d
```{{exec}}

### 3. Verify Deployment
Wait a moment for the containers to initialize, then check that they are running:

```bash
docker-compose ps
```{{exec}}

Once both `gitea` and `db` are in a `Up` state, you are ready to configure Gitea in the next step.
