
# For links to ports:

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```

# add these sections

- https://github.com/docker/compose
- https://github.com/docker/buildx

command to check memory available for a docker imagine

docker run --rm "debian:bookworm-slim" bash -c 'numfmt --to iec $(echo $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE))))'

for #cores: nproc
for power: lscpu

docker run --rm "debian:bookworm-slim" bash -c 'nproc'
docker run --rm "debian:bookworm-slim" bash -c 'lscpu'

To estimate the power of the CPU core based on the `lscpu` output provided, you can consider the following three key items:

1. **Model Name**: The `Model name` field provides information about the specific model of the CPU. In this case, the model is "Intel Xeon E312xx (Sandy Bridge, IBRS update)". The model name can give you an idea of the generation and performance level of the CPU.

2. **BogoMIPS**: The `BogoMIPS` value is a rough estimation of the performance of the CPU core in terms of million instructions per second. While not a precise benchmark, it can give you a general idea of the processing power of the CPU core. In this case, the BogoMIPS value is "7199.98".

3. **Cache Sizes**: The cache sizes, particularly the L1, L2, and L3 cache sizes, can also provide insights into the performance of the CPU core. Larger cache sizes generally indicate better performance as they help reduce the time taken to access frequently used data. In this case, the L1d cache is 32 KiB, L2 cache is 4 MiB, and L3 cache is 16 MiB.

By considering the `Model name`, `BogoMIPS`, and cache sizes from the `lscpu` output, you can get a good estimate of the power and performance level of the CPU core in the Docker container.
