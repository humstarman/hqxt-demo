apiVersion: extensions/v1beta1
kind: DaemonSet 
metadata:
  labels:
    component: demo3 
  name: demo3
  namespace: {{.namespace}}
spec:
  selector:
    matchLabels:
      component: demo3 
  template:
    metadata:
      labels:
        component: demo3
    spec:
      terminationGracePeriodSeconds: 3
      restartPolicy: Always
      containers:
        - name: demo3
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
