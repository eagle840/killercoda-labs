# Lab Complete!

Congratulations! You've successfully mastered the fundamentals of **AWS CloudFormation** using the MiniStack emulator.

### What you've learned:
- **The Lifecycle:** Writing, validating, and deploying templates using `create-stack`.
- **Dynamic Infrastructure:** Using `Parameters` and `!Sub` to build environment-aware resources.
- **Wiring & Outputs:** Connecting resources (SNS to SQS) and exposing metadata.
- **Event-Driven Architectures:** Routing custom events through EventBridge and CloudWatch Logs.
- **Drift Management:** Identifying and remediating configuration divergence between code and reality.

### Cleanup
In a local lab, you can simply stop the containers. But to practice good cloud hygiene, delete your stack:

```bash
awslocal cloudformation delete-stack --stack-name local-core-infra
```{{exec}}

You are now ready to take these Infrastructure as Code (IaC) skills to real-world AWS environments!
