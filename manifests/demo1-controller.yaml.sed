kind: Deployment
apiVersion: extensions/v1beta1
metadata:
  name: demo1
  namespace: {{.namespace}}
spec:
  replicas: 1
  template:
    metadata:
      labels:
        component: demo1
    spec:
      terminationGracePeriodSeconds: 10
      containers:
        - name: demo1
          image: {{.image}} 
          imagePullPolicy: {{.image.pull.policy}}
          command:
            - /entrypoint.sh
          args:
            - -p
            - "{{.port}}"
          env:
            - name: HOST_IP
              valueFrom:
                fieldRef:
                  fieldPath: status.hostIP
            - name: POD_IP
              valueFrom:
                fieldRef:
                  fieldPath: status.podIP
          livenessProbe:
            httpGet:
              path: /healthz
              port: {{.port}}
            initialDelaySeconds: 10 
            periodSeconds: 15 
          volumeMounts:
            - name: host-time
              mountPath: /etc/localtime
              readOnly: true
      volumes:
        - name: host-time
          hostPath:
            path: /etc/localtime
