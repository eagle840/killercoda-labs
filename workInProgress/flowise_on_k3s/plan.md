# Lab Plan: Deploying Flowise on k3s

This lab guides you through deploying Flowise on a k3s cluster using the community-maintained Helm chart by HelmForge.

## Objectives
- Install k3s.
- Add the HelmForge repository.
- Deploy Flowise using Helm.
- Verify the deployment.

## Steps
1. **Setup k3s**: Install and initialize k3s.
2. **Add Repo**: Add the HelmForge Helm repository.
3. **Deployment**: Install Flowise via Helm (using default SQLite for the lab).
4. **Expose Service**: Configure port-forwarding to expose the Flowise UI.
5. **Verification**: Confirm pods are running and access the Flowise portal via the Killercoda UI.

## References
- [Flowise GitHub Issue #6111](https://github.com/FlowiseAI/Flowise/issues/6111)
- [HelmForge Flowise Chart](https://github.com/helmforge/flowise)
