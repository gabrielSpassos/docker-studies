# Jenkins POC

## What is Jenkins?

🔧 Jenkins is an open-source automation server used to build, test, and deploy software. It supports CI/CD pipelines and integrates with many tools and platforms.

## Use Cases
- ✅ CI/CD for applications and microservices
- ✅ Automated testing workflows
- ✅ Container builds with Docker
- ✅ Infrastructure automation with Ansible, Terraform, OpenTofu

## Install with helm

* Install
```bash
helm repo add jenkins https://charts.jenkins.io
helm repo update

helm install jenkins jenkins/jenkins -n jenkins-poc --create-namespace
```

* Get pods and services
```bash
kubectl get pods -A
kubectl get service -n jenkins-poc
```

* Get `admin` user password
```bash
kubectl get secret --namespace jenkins-poc jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode
```
Sample: clMmrVOv2W7LPmlBvBg5oe

* Expose service
```bash
kubectl --namespace jenkins-poc port-forward svc/jenkins 8080:8080
```

* Access http://127.0.0.1:8080/ and login with `admin` and the password
![Login](https://github.com/gabrielSpassos/docker-studies/blob/master/jenkins-poc/resources/jenkins-login.png)

* Hello world job
![basic-job](https://github.com/gabrielSpassos/docker-studies/blob/master/jenkins-poc/resources/basic-job.png)

