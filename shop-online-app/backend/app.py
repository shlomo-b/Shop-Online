from flask import Flask, request, jsonify
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash
from pymongo import MongoClient, ASCENDING
from bson import ObjectId
import sys
import os
import time
import psutil
from prometheus_client import Counter, Gauge, Histogram, generate_latest
from flask import Flask, Response, render_template, request, g

app = Flask(__name__)

GAMES_PLAYED = Counter('react_online_shop', 'Number of sales made')
SITE_VISITS = Counter('site_visits', 'Number of visits to the shop site')

# System metrics
CPU_USAGE = Gauge('cpu_usage_percent', 'Current CPU usage in percent')
MEMORY_USAGE = Gauge('memory_usage_bytes', 'Current memory usage in bytes')
NETWORK_IO_COUNTERS = Gauge('network_io_bytes', 'Network I/O counters', ['direction'])

# HTTP metrics
HTTP_REQUESTS = Counter('http_requests_total', 'Total number of HTTP requests', ['method', 'endpoint', 'status_code'])
HTTP_REQUEST_DURATION = Histogram('http_request_duration_seconds', 'Histogram of HTTP request durations',
                                  ['method', 'endpoint'])

# Updated CORS configuration to be more permissive during development
CORS(app, resources={
    r"/api/*": {
        "origins": "*",  # Allow all origins during development
        "methods": ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        "allow_headers": ["Content-Type", "Authorization", "Access-Control-Allow-Origin"],
        "expose_headers": ["Content-Type", "Authorization"],
        "supports_credentials": True,
        "max_age": 600
    }
})

# app.secret_key = 'tomer'

@app.before_request
def track_request_start():
    # Record the start time of the request
    g.start_time = time.time()


@app.after_request
def track_request_end(response):
    # Measure request duration
    if hasattr(g, 'start_time'):
        request_duration = time.time() - g.start_time
        HTTP_REQUEST_DURATION.labels(method=request.method, endpoint=request.path).observe(request_duration)

    # Count the request
    HTTP_REQUESTS.labels(method=request.method, endpoint=request.path, status_code=response.status_code).inc()

    return response

# Add CORS headers to all responses
@app.after_request
def after_request(response):
    # Allow all origins during development
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    return response

@app.route('/metrics')
def metrics():
    # Update system metrics before serving
    CPU_USAGE.set(psutil.cpu_percent())
    MEMORY_USAGE.set(psutil.virtual_memory().used)
    net_io = psutil.net_io_counters()
    NETWORK_IO_COUNTERS.labels('in').set(net_io.bytes_recv)
    NETWORK_IO_COUNTERS.labels('out').set(net_io.bytes_sent)

    # Return Prometheus metrics in the required format
    return Response(generate_latest(), mimetype='text/plain')

def setup_mongodb():
    max_retries = 5
    retry_delay = 3  # seconds
    
    for attempt in range(max_retries):
        try:
            # Get MongoDB connection details from environment variables
            username = os.environ.get('MONGO_INITDB_ROOT_USERNAME')
            password = os.environ.get('MONGO_INITDB_ROOT_PASSWORD')
            host = os.environ.get('MONGO_DB_HOST')
            
            # Construct MongoDB connection URI with authentication database
            mongo_uri = f'mongodb://{username}:{password}@{host}:27017/?authSource=admin'
            print(f"Attempt {attempt + 1}: Connecting to MongoDB at {host}")
            
            # Connect to MongoDB
            client = MongoClient(mongo_uri, 
                               serverSelectionTimeoutMS=5000,
                               connectTimeoutMS=5000)
            
            # Test the connection
            client.admin.command('ping')
            print("Successfully connected to MongoDB")
            
            # Select and setup database
            db = client['ecommerce_db']
            
            # Setup collections
            users_collection = db['users']
            products_collection = db['products']
            
            # Create indexes if they don't exist
            users_collection.create_index([('username', ASCENDING)], unique=True)
            products_collection.create_index([('name', ASCENDING)])
            
            print("MongoDB setup completed successfully!")
            return client, db, users_collection, products_collection
            
        except Exception as e:
            print(f"Attempt {attempt + 1} failed: {str(e)}")
            if attempt < max_retries - 1:
                print(f"Retrying in {retry_delay} seconds...")
                time.sleep(retry_delay)
            else:
                print("Max retries reached. Could not connect to MongoDB.")
                sys.exit(1)

# Initialize MongoDB
client, db, users_collection, products_collection = setup_mongodb()

@app.route('/api/health', methods=['GET'])
def health_check():
    try:
        client.admin.command('ping')
        return jsonify({
            'status': 'healthy',
            'database': 'connected',
            'collections': db.list_collection_names(),
            'mongodb_host': os.environ.get('MONGO_DB_HOST', 'mongo')
        })
    except Exception as e:
        return jsonify({
            'status': 'unhealthy',
            'error': str(e),
            'mongodb_host': os.environ.get('MONGO_DB_HOST', 'mongo')
        }), 500

@app.route('/api/register', methods=['POST'])
def register():
    print("Received registration request")
    try:
        data = request.get_json()
        if not data:
            return jsonify({'message': 'No data provided'}), 400
            
        username = data.get('username')
        password = data.get('password')
        
        if not username or not password:
            return jsonify({'message': 'Username and password are required'}), 400
        
        # Check if user already exists
        if users_collection.find_one({'username': username}):
            return jsonify({'message': 'Username already exists'}), 409
        
        user = {
            'username': username,
            'password': generate_password_hash(password)
        }
        users_collection.insert_one(user)
        
        return jsonify({'message': 'Registration successful'}), 201
        
    except Exception as e:
        print(f"Registration error: {str(e)}")
        return jsonify({'message': 'Registration failed', 'error': str(e)}), 500

@app.route('/api/users', methods=['GET'])
def get_users():
    try:
        users = list(users_collection.find({}, {'password': 0}))
        for user in users:
            user['_id'] = str(user['_id'])
        return jsonify(users)
    except Exception as e:
        return jsonify({'message': f'Error fetching users: {str(e)}'}), 500

@app.route('/api/login', methods=['POST', 'GET'])
def login():
    try:
        if request.method == 'GET':
            return jsonify({'message': 'Please use POST to login'}), 200

        # Handle POST request
        data = request.get_json()
        if not data:
            return jsonify({'message': 'Missing JSON data'}), 400

        username = data.get('username')
        password = data.get('password')

        user = users_collection.find_one({'username': username})

        if user and check_password_hash(user['password'], password):
            return jsonify({
                'message': 'Login successful',
                'username': username
            }), 200

        return jsonify({'message': 'Invalid credentials'}), 401
    except Exception as e:
        return jsonify({'message': f'Login error: {str(e)}'}), 500


@app.route('/api/products', methods=['GET'])
def get_products():
    try:
        products = list(products_collection.find())
        for product in products:
            product['_id'] = str(product['_id'])
        return jsonify(products)
    except Exception as e:
        return jsonify({'message': f'Error fetching products: {str(e)}'}), 500

@app.route('/api/products', methods=['POST'])
def add_product():
    try:
        data = request.get_json()
        if not data:
            return jsonify({'message': 'No data provided'}), 400
            
        product = {
            'name': data.get('name'),
            'price': float(data.get('price', 0)),
            'description': data.get('description', '')
        }
        
        if not product['name']:
            return jsonify({'message': 'Product name is required'}), 400
            
        result = products_collection.insert_one(product)
        product['_id'] = str(result.inserted_id)
        return jsonify({'message': 'Product added successfully', 'product': product}), 201
    except Exception as e:
        return jsonify({'message': f'Error adding product: {str(e)}'}), 500

@app.route('/api/products/<product_id>', methods=['DELETE'])
def delete_product(product_id):
    try:
        result = products_collection.delete_one({'_id': ObjectId(product_id)})
        if result.deleted_count:
            return jsonify({'message': 'Product deleted successfully'}), 200
        return jsonify({'message': 'Product not found'}), 404
    except Exception as e:
        return jsonify({'message': f'Error deleting product: {str(e)}'}), 400

if __name__ == '__main__':
    app.run(debug=True, port=5050, host='0.0.0.0')