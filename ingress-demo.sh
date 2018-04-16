!/bin/bash

########################
# include the magic
########################
. demo-magic.sh

# hide the evidence
clear

pe "kubectl cluster-info"

echo "================================================================"
pe "docker ps --format '{{.Image}}' | egrep contrail"

wait 

echo "=======================web-app-rc-dev========================================="
cat web-app-rc-dev.yaml   

wait 

echo "=======================web-app-rc-qa========================================="
cat web-app-rc-qa.yaml

wait
echo "=======================web-app-svc-dev========================================="
cat web-app-svc-dev.yaml

wait
echo "=======================web-app-svc-qa========================================="
cat web-app-svc-qa.yaml

wait
echo "=======================web-app-fanout-ingress========================================="
cat web-app-fanout-ingress.yaml  

wait


echo "================================================================"
echo ">kubectl apply -f  web-app-rc-dev.yaml"
echo ">kubectl apply -f  web-app-rc-qa.yaml"
echo ">kubectl apply -f  web-app-svc-dev.yaml"
echo ">kubectl apply -f  web-app-svc-qa.yaml"
echo ">kubectl apply -f  web-app-fanout-ingress.yaml"

wait

echo "================================================================"
pe "kubectl get rc -o wide"

wait

echo "================================================================"
pe "kubectl get svc -o wide"

wait

echo "================================================================"
pe "kubectl get ing -o wide"

wait

echo ""
echo "Checkout : http://10.84.59.30/dev"
