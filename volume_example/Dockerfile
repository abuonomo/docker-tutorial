# Each lines in this Dockerfile defines a layer of the resultant image.
# I won't delve into what exactly this means here. 

FROM ubuntu

RUN apt-get update &&\
    apt-get install curl

VOLUME ./data/:/home/data/ 

WORKDIR /home/

CMD curl google.com >> data/google.html
