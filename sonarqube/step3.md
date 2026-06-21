# Step 3: Advanced SonarQube Configuration

In this final step, we will move beyond basic scanning to understand how SonarQube enforces project quality standards using **Quality Gates** and how to extend its functionality via the **Marketplace**.

---

## 1. Quality Gates: Enforcing Standards

A **Quality Gate** is a set of boolean conditions (e.g., "Must have less than 5 code smells") that a project must meet to be considered "clean" or "releasable."

### Create a Custom Quality Gate

1. Log into your SonarQube server (`http://localhost:9000`).
2. Navigate to **Quality Gates** in the top navigation bar.
3. Click **Create** and name it `strict-python-gate`.
4. Click **Add Condition** to add a new rule:
   - Select **Code Smells**.
   - Set the operator to **is greater than**.
   - Set the value to **0** on **New Code**.
   - This means: *If any new code smell is detected, the project will fail the Quality Gate.*
5. Click **Add** to save the condition.

### Attach the Gate to Your Project

1. Navigate to **Projects** and click on your `pyproject` project.
2. Go to **Project Settings** -> **Quality Gate**.
3. Select `strict-python-gate` from the dropdown list.
4. Click **Set**.

### Verify the Failure

Now, run the scanner again on your project (which still has the empty `except` code smell from Step 2):

```bash
sonar-scanner -Dsonar.token="$SONAR_TOKEN"
```{{exec}}

Back in the dashboard, you will notice that the `pyproject` now shows a **Failed** status on the Quality Gate. This is the core mechanism used in CI/CD pipelines to block builds from being merged if they introduce poor-quality code!

---

## 2. Exploring the Marketplace

SonarQube's capabilities (like support for specific languages, security rules, or integrations) can be extended through plugins.

1. Navigate to **Administration** -> **Marketplace** in the top navigation bar.
2. Here you can search for and install plugins to extend functionality, such as:
   - Additional language support (e.g., for specialized frameworks).
   - DevOps tool integrations (e.g., Pull Request decoration).
   - Security rule sets.

*Note: In a production environment, you would carefully vet plugins before installing them. For this lab, feel free to browse the available plugins to see how SonarQube can be tailored to different ecosystems.*

---

## Conclusion of Lab

You have successfully:
1. Set up a SonarQube instance.
2. Created a local Python project with Git version control.
3. Used the official CLI scanner to analyze code.
4. Identified and analyzed a code smell.
5. Configured a custom Quality Gate to enforce standards.

You are now ready to implement these practices in your own development projects!
