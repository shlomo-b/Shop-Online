from flask import Flask, render_template, Response
import prometheus_client
from prometheus_client import Counter, Gauge
import psutil

# i do that because the flask uses the templates folder  , and i'm uses folder app
app = Flask(__name__, template_folder='')

# Create Prometheus metrics
GAMES_PLAYED = Counter('games_played', 'Number of Blackjack games played')
SITE_VISITS = Counter('site_visits', 'Number of visits to the Blackjack site')

# collect  metrics
CPU_USAGE = Gauge('cpu_usage_percent', 'Current CPU usage in percent')
MEMORY_USAGE = Gauge('memory_usage_bytes', 'Current memory usage in bytes')
NETWORK_IO_COUNTERS = Gauge('network_io_bytes', 'Network I/O counters', ['direction'])


# return the valuse of the game
@app.route('/')
def index():
    return render_template('blackjack.html')


# presentation of the project
@app.route('/presentation')
def presentation():
    return render_template('presentation.html')


# return the valuse of the /metrics
@app.route('/metrics')
def metrics():
    # Update metrics before serving
    CPU_USAGE.set(psutil.cpu_percent())
    MEMORY_USAGE.set(psutil.virtual_memory().used)
    net_io = psutil.net_io_counters()
    NETWORK_IO_COUNTERS.labels('in').set(net_io.bytes_recv)
    NETWORK_IO_COUNTERS.labels('out').set(net_io.bytes_sent)

    return Response(prometheus_client.generate_latest(), mimetype='text/plain')


# the file is main.
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)