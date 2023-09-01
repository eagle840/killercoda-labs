
    # Install Istio
    curl -L https://istio.io/downloadIstio | sh -
    cd istio-1.11.2
    export PATH=$PWD/bin:$PATH
    istioctl install --set profile=demo
    kubectl label namespace default istio-injection=enabled


       # Verify Istio installation
    istioctl version
    kubectl get pods -n istio-system 
