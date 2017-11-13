import pickle
import os
from flask import Flask

PORT = os.environ['PORT']

app = Flask(__name__)

@app.route('/')
def hitchhikers():
    # Reads lines from txt file in data volume.
    return('This app runs on network 2.') 

# Must run on 0.0.0.0 to be visible to other containers.
app.run(host="0.0.0.0", port=PORT)
