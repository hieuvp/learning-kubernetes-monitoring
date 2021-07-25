# Beats

## Filebeat

Filebeat monitors the log files or locations that you specify,
collects log events, and forwards them either to Elasticsearch or Logstash for indexing.

![Filebeat](https://www.elastic.co/guide/en/beats/filebeat/current/images/filebeat.png)

## Metricbeat

Metricbeat is a lightweight shipper that you can install on your servers to periodically collect metrics from the operating system and from services running on the server.
Metricbeat takes the metrics and statistics that it collects and ships them to the output that you specify, such as Elasticsearch or Logstash.

Metricbeat helps you monitor your servers by collecting metrics from the system and services running on the server, such as:

- Apache
- HAProxy
- MongoDB
- MySQL
- Nginx
- PostgreSQL
- Redis
- System
- Zookeeper

## References

- [Elastic Stack on Kubernetes 1.15 using Helm v3](https://itnext.io/deploy-elastic-stack-on-kubernetes-1-15-using-helm-v3-9105653c7c8)
