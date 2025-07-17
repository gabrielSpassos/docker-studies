* Start docker containers
```bash
docker-compose up
```

* Access prometheus http://localhost:9090

* Query: `{job="flask_poc_app"}`

* Access grafana http://localhost:3000/
* User/Pass `admin/admin`
* Dashboard sample: https://grafana.com/grafana/dashboards/17629-prometheus-flask-exporter-dashboard/
    * change job name on query
 
![dash](https://github.com/gabrielSpassos/docker-studies/blob/master/devops-poc/monitoring/resources/grafana-dash.png)
