172.16.118.126
``` bash
#Création d’un utilisateur pour Prometheus
sudo useradd --no-create-home --shell /bin/false prometheus

#on se place dans le repertoire opt pour dl prometheus
cd /opt
wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz

#On extrait prometheus et on créer les dossier nécessaire à son fonctionnement en lui donnant ces autorisations.
tar -xzf prometheus-2.47.0.linux-amd64.tar.gz
sudo mv prometheus-*/prometheus /usr/local/bin/ sudo mv prometheus-*/promtool /usr/local/bin/ sudo mkdir /etc/prometheus sudo mkdir /var/lib/prometheus sudo mv prometheus-*/consoles /etc/prometheus sudo mv prometheus-*/console_libraries /etc/prometheus sudo mv prometheus-*/prometheus.yml /etc/prometheus sudo chown prometheus:prometheus /usr/local/bin/prometheus sudo chown prometheus:prometheus /usr/local/bin/promtool sudo chown -R prometheus:prometheus /etc/prometheus sudo chown -R prometheus:prometheus /var/lib/prometheus

#on cree un systemd pour prometheus
nano /etc/systemd/system/prometheus.service
[Unit] Description=Prometheus Monitoring Wants=network-online.target After=network-online.target [Service] User=prometheus Group=prometheus Type=simple ExecStart=/usr/local/bin/prometheus \ --config.file /etc/prometheus/prometheus.yml \ --storage.tsdb.path /var/lib/prometheus/ \ --web.console.templates=/etc/prometheus/consoles \ --web.console.libraries=/etc/prometheus/console_libraries [Install] WantedBy=multi-user.target
# on active et on demarre le service 
sudo systemctl daemon-reload sudo systemctl enable prometheus sudo systemctl start prometheus
#accedons au panel http://172.16.118.126:9090
#installons grafana pour avoir un visuel
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
#accedons au panel http://172.16.118.126:3000
#on va dans connections data source et on ajoute prometheus
#on installe les exporters dont prometheus a besoin sur l'ad le glpi et le serveur minecraft
#on edite le fichier pour configurer prometheus
nano /etc/prometheus/prometheus.yml
#on rajoute l'ad
scrape_configs:
  - job_name: 'active_directory'
    static_configs:
      - targets: ['172.16.118.124:9182']
#on se fait un dashboard
#installons un exporters sur la glpi
sudo apt update
sudo apt install -y prometheus-node-exporter
#on verifie que ca tourne
systemctl status prometheus-node-exporter
#on verifie que on a bien des metrics de sorties
curl http://localhost:9100/metrics
# on le rajoute au fichier config
scrape_configs:
  - job_name: 'glpi_server'
    static_configs:
      - targets: ['172.16.118.122:9100']
#on configure des requetes plus precises 
#on recupere le token de l'api glpi 
#on installe flask pour faire un script 
apt install python3-pip 
apt install python3.11-venv
source .venv/bin/activate
pip3 install flask requests prometheus_client7


#on cree notre script 

touch glpi_exporter.py

from flask import Flask
from prometheus_client import generate_latest, Gauge
import requests

app = Flask(__name__)

# Exemple : Récupérer le nombre de tickets ouverts via l'API GLPI
GLPI_URL = "http://votre_serveur_glpi/apirest.php"
GLPI_APP_TOKEN = "votre_app_token"
GLPI_USER_TOKEN = "votre_user_token"

tickets_gauge = Gauge('glpi_open_tickets', 'Nombre de tickets ouverts dans GLPI')

def get_open_tickets():
    headers = {
        "App-Token": GLPI_APP_TOKEN,
        "Session-Token": GLPI_USER_TOKEN
    }
    response = requests.get(f"{GLPI_URL}/Ticket/", headers=headers)
    if response.status_code == 200:
        tickets = response.json()
        return len(tickets)
    return 0

@app.route('/metrics')
def metrics():
    tickets_gauge.set(get_open_tickets())
    return generate_latest()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9100)
#on lance le script python
python3 glpi_exporters


```


