
import os
from flask import Flask

PORT = os.environ['PORT']

app = Flask(__name__)

@app.route('/')
def hello_world():
        return '“Space,” it says, “is big. Really big. You just won’t believe how vastly, hugely, mindbogglingly big it is. I mean, you may think it’s a long way down the road to the chemist’s, but that’s just peanuts to space.”'

# Must run on 0.0.0.0 to be visible to other containers.
app.run(host="0.0.0.0", port=PORT)
