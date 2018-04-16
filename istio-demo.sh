!/bin/bash

########################
# include the magic
########################
. demo-magic.sh

# hide the evidence
clear

echo -e "${GREEN}Istio components:${COLOR_RESET}"
pe "kubectl get pods -n istio-system"
echo "================================================================"

wait

echo -e "${GREEN}Istio components:${COLOR_RESET}"
pe "kubectl get svc -n istio-system"
echo "================================================================"

wait

echo -e "${GREEN}Bookinfo pods:${COLOR_RESET}"
pe "kubectl get pods"
echo "================================================================"

wait

echo -e "${GREEN}Bookinfo service:${COLOR_RESET}"
pe "kubectl get svc"
echo "================================================================"

wait

echo -e "${GREEN}Containers running in pod:${COLOR_RESET}"
pe "kubectl get pods productpage-v1-7bbb998d94-8sgbg -o jsonpath='{.spec.containers[*].name}'"
echo "================================================================"

wait

echo -e "${GREEN}Basic pod yaml:${COLOR_RESET}"
cat sleep.yaml
echo "================================================================"

wait

echo -e "${GREEN}Kube-injected output:${COLOR_RESET}"
pe "istioctl kube-inject -f sleep.yaml"
echo "================================================================"

wait


echo -e "${GREEN}kubectl apply:${COLOR_RESET}"
pe "kubectl apply -f <(istioctl kube-inject -f sleep.yaml)"
echo "================================================================"

wait

echo -e "${GREEN}Check pod running:${COLOR_RESET}"
pe "kubectl get pods"
echo "================================================================"

wait



echo -e "${GREEN}Describe sleep pod:${COLOR_RESET}"
pe "kubectl describe po sleep"
echo "================================================================"

wait

echo -e "${GREEN}Check inside sleep pod:${COLOR_RESET}"
sleep_pod=$(kubectl get pods | egrep sleep | awk '{print $1}')
pe "kubectl exec -it $sleep_pod -c istio-proxy bash"
echo "================================================================"
wait



echo -e "${GREEN}Lets open product page:${COLOR_RESET}"
echo "http://10.84.59.27:9080/productpage?u=normal"
echo "================================================================"

wait

echo -e "${GREEN}Example 1:${COLOR_RESET}"
echo "The example below will send all traffic for the user jason to the reviews:v2, meaning they'll only see the black stars."
echo ""
cat route-rule-reviews-test-v2.yaml
echo ""
echo ">"
pe "istioctl create -f route-rule-reviews-test-v2.yaml"

wait



echo "================================================================"
echo ""
echo -e "${GREEN}Example 2:${COLOR_RESET}"
echo "The rule below ensures that 50% of the traffic goes to reviews:v1 (no stars), or reviews:v3 (red stars)."
echo ""
cat route-rule-reviews-50-v3.yaml
echo ""
echo ">"
pe "istioctl create -f route-rule-reviews-50-v3.yaml"

wait





echo "================================================================"
echo ""
echo -e "${GREEN}Example 3:${COLOR_RESET}"
echo "we'd want to move 100% of the traffic to reviews:v3."
echo ""
cat route-rule-reviews-v3.yaml
echo ""
echo ">"
pe "istioctl replace -f route-rule-reviews-v3.yaml"

wait



echo "================================================================"
echo ""
echo -e "${GREEN}Rules created :${COLOR_RESET}"
echo ""
echo ">"
pe "istioctl get routerules"

wait

echo "================================================================"
echo ""
echo -e "${GREEN}Zipkin tracing :${COLOR_RESET}"
echo ""
echo "http://10.84.59.31:9411/zipkin/?serviceName=productpage"
echo ""

wait

echo "================================================================"
echo ""
echo -e "${GREEN}Graphana :${COLOR_RESET}"
echo "The first is the Istio Grafana Dashboard. The dashboard returns the total number of requests currently being processed, along with the number of errors and the response time of each call. Prometheus gathers metrics from the Mixer. Grafana produces dashboards based on the data collected by Prometheus."
echo "http://10.84.59.29:3000/"
echo ""

wait
