# Finished!

You have completed the Zingg lab. 🎉

## Clean‑up

```bash
# Stop the Zingg container (if still running)
docker ps | grep zingg && docker stop $(docker ps -q --filter "ancestor=zingg/zingg:0.3.4")

# Remove temporary output directory
rm -rf /tmp/zinggOutput
```

## Next steps
- Try the **advanced** objectives (tune parameters, integrate into a pipeline, deploy to the cloud).
- Explore the official Zingg docs: https://docs.zingg.ai/
- Share your findings on the Killercoda community.

Happy matching!