#!/bin/bash
kubectl get po -A -owide --sort-by '{.spec.nodeName}'