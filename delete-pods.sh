#!/bin/bash

#删除一个ns中的所有状态为Evited的pod
#kubectl get pods -n jenkins-k8s | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n jenkins-k8s

#删除所有ns中Evited的pod
#for ns in `kubectl get ns | awk 'NR>1{print $1}'`
#do
#      kubectl get pods -n ${ns} | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n ${ns}
#done