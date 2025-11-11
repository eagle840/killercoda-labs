You now have a fully functional monitoring stack! Here are a few ideas to explore further:

### Simulate CPU Load

You can generate some CPU load on the host machine and watch the graphs in Grafana update in real-time.

First, install the `stress` utility.
```bash
apt-get update && apt-get install -y stress
```{{exec}}

Now, run `stress` to generate load on 2 CPU cores for 60 seconds.
```bash
stress --cpu 2 --timeout 60
```{{exec}}

While this is running, go back to your Grafana dashboard and watch how the CPU usage graph responds to the increased load.

### Explore Telegraf Plugins

Telegraf has a vast library of input plugins that allow you to collect metrics from many different sources. You can try enabling other plugins in your `telegraf.conf` file.

For example, to monitor your Docker containers, you could add the `[[inputs.docker]]` plugin.

This concludes the lab, but feel free to continue experimenting with your new monitoring environment.
