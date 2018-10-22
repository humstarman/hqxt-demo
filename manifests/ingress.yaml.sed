apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: {{.name}} 
  namespace: {{.namespace}} 
spec:
  rules:
  - host: test.demo1.me 
    http:
      paths:
      - path: /
        backend:
          serviceName: demo1-proxy 
          servicePort: {{.port}}
  - host: test.demo3.me 
    http:
      paths:
      - path: /
        backend:
          serviceName: demo3-proxy 
          servicePort: {{.port}}
