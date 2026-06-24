# Step 5: Remediation & Verification

Now, we will remediate the security findings in both our dependencies (`package.json`) and our container settings (`Dockerfile`) to secure the application.

### 1. Update package.json to Secure Package Versions
Overwrite the vulnerable `package.json` with upgraded versions (e.g. `lodash` to `4.17.21` and `express` to `4.18.2`):
```bash
cat << 'EOF' > /root/project/package.json
{
  "name": "mock-sec-app",
  "version": "1.0.0",
  "description": "A demo application with secured dependencies",
  "main": "index.js",
  "dependencies": {
    "lodash": "4.17.21",
    "express": "4.18.2"
  }
}
EOF
```{{execute}}

### 2. Update Dockerfile to Secure Configurations
Overwrite the `Dockerfile` to use a modern, secure alpine-based image and explicitly add a non-root user to execute the app:
```bash
cat << 'EOF' > /root/project/Dockerfile
FROM alpine:3.18

# Create a non-root group and user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY package.json .

# Install dependencies securely
RUN apk add --no-cache nodejs npm && npm install

COPY . .

# Run container as a non-root user
USER appuser

CMD ["node", "index.js"]
EOF
```{{execute}}

### 3. Remove `.trivyignore`
Since we have properly secured our Dockerfile by specifying a non-root user, we no longer need to bypass the check. Delete `.trivyignore`:
`rm /root/project/.trivyignore`{{execute}}

### 4. Run the Build Pipeline Again
Execute the build script:
`/root/project/build.sh`{{execute}}

The output will show:
1. `trivy config` runs successfully without failures.
2. `trivy fs` scans our local code directory and finds zero High or Critical vulnerabilities.
3. The build completes with: `BUILD SUCCESSFUL! All security gates passed.`

Congratulations! You have successfully implemented Software Composition Analysis (SCA) and gated a pipeline using Trivy.
