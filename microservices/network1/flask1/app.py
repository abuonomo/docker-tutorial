import pickle
import os
from flask import Flask

PORT = os.environ['PORT']

app = Flask(__name__)

@app.route('/')
def hitchhikers():
    # Reads lines from txt file in data volume.
    lines = [line.rstrip('\n') for line in open('hitchhikers_quotes.txt')]

    # Reads counter value from pkl file in data volume.
    if os.path.exists('data/counter.pkl'):
        with open('data/counter.pkl', 'rb+') as f0:
            counter = pickle.load(f0)     
    else:
        counter = 0
        with open('data/counter.pkl', 'wb+') as f0:
            pickle.dump(1, f0)

    # Increment counter by 1 and dump (reset if new_counter is length of all lines)
    new_counter = counter + 1
    if new_counter == len(lines):
       new_counter = 0
    with open('data/counter.pkl', 'wb+') as f0:
        pickle.dump(new_counter, f0)

    return(lines[counter]) 

#return '“Space,” it says, “is big. Really big. You just won’t believe how vastly, hugely, mindbogglingly big it is. I mean, you may think it’s a long way down the road to the chemist’s, but that’s just peanuts to space.”'

# Must run on 0.0.0.0 to be visible to other containers.
app.run(host="0.0.0.0", port=PORT)
