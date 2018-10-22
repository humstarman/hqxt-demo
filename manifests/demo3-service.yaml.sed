apiVersion: v1
kind: Service
metadata:
  namespace: {{.namespace}}
  labels:
    proxy: demo3
  name: demo3-proxy
spec:
  type: ClusterIP
  ports:
  - name: http 
    port: {{.port}} 
    targetPort: {{.port}}
  selector:
    component: demo3
