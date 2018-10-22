apiVersion: v1
kind: Service
metadata:
  namespace: {{.namespace}}
  labels:
    proxy: demo1
  name: demo1-proxy
spec:
  type: ClusterIP
  ports:
  - name: http 
    port: {{.port}} 
    targetPort: {{.port}}
  selector:
    component: demo1
