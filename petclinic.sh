#!/usr/bin/env bash

printf "\n\n######## Deploying Quarkus Petclinic ########\n"

kubectl apply -f src/main/kubernetes/deployment.yml
kubectl wait --for=condition=available --timeout=60s deployment/quarkus-petclinic

kubectl get services
oc expose svc quarkus-petclinic
oc patch -p '{"spec":{"$setElementOrder/ports":[{"port":8080},{"port":9091}],"ports":[{"name":"9091-tcp","port":9091,"protocol":"TCP","targetPort":9091}]}}' svc quarkus-petclinic
