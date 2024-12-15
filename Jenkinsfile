

































// pipeline {
//     agent any

//     stages {
//         stage('docker-run-front') {
//             steps {
//                 script {
//                     // Use 'sh' step to execute shell commands
//                     sh 'docker run -d -p 81:80 oksesaneka22/awsclone:front-v1'
//                 }
//             }
//         }
//         stage('docker-run-sql') {
//             steps {
//                 script {
//                     // Use 'sh' step to execute shell commands
//                     sh 'docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Qwerty-1" -p 1433:1433 --name sql111 --hostname sql1 -d mcr.microsoft.com/mssql/server:2022-latest'
//                 }
//             }
//         }
//         stage('docker-run-back') {
//             steps {
//                 script {
//                     // Use 'sh' step to execute shell commands
//                     sh 'docker run -d -p 5034:5034 oksesaneka22/awsclone:back-v1'
//                 }
//             }
//         }
//         stage('docker-run-grafana') {
//             steps {
//                 script {
//                     // Use 'sh' step to execute shell commands
//                     sh 'docker run -d --name grafana -p 3000:3000 -v grafana-data:/var/lib/grafana oksesaneka22/grafana:grafana-v1'
//                     sh 'docker run -d --name prometheus -p 9090:9090 -v prom-data:/prometheus oksesaneka22/grafana:prometheus-v1'
//                     sh 'docker run -d --name alertmanager -p 9093:9093 -v alert-data:/alertmanager oksesaneka22/grafana:alertmanager-v1'
//                     sh 'docker run -d --name node-exporter -p 9100:9100 -v /proc:/host/proc:ro -v /sys:/host/sys:ro -v /:/rootfs:ro oksesaneka22/grafana:node-exporter-v1'
//                     sh 'docker run -d --name cadvisor -p 8081:8080 -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys:ro -v /var/lib/docker/:/var/lib/docker:ro oksesaneka22/grafana:cadvisor-v1'
//                     sh 'docker ps'
//                 }
//             }
//         }
//     }
// }
