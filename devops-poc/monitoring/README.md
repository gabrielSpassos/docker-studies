# Prometheus and Grafana

🔥**Prometheu**s is an open-source monitoring system and time-series database designed for collecting metrics from applications and infrastructure. It scrapes data from endpoints (like /metrics) and stores it for querying and alerting.

📊 **Grafana** is an open-source analytics and visualization tool that connects to data sources like Prometheus. It lets you create real-time, interactive dashboards to monitor your systems and applications.

## Usage

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
    ![dash1](https://github.com/gabrielSpassos/docker-studies/blob/master/devops-poc/monitoring/resources/grafana-dash.png)

* Other dash to import via json: https://github.com/rycus86/prometheus_flask_exporter/blob/master/examples/sample-signals/grafana/dashboards/example.json
    * change job name on query
    ![dash2](https://github.com/gabrielSpassos/docker-studies/blob/master/devops-poc/monitoring/resources/grafana-dash2.png)
