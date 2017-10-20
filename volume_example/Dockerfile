FROM ubuntu

RUN apt-get update &&\
    apt-get install curl -y
# Notice here that I put both apt-get commands into one RUN command.
# In other words, I did not use the two lines below
# RUN apt-get update
# RUN apt-get install curl
# I put these into one RUN command because each command defines a layer of
# the resultant image. In cases like this, where you are difining the particular set of dependenices, it is best to use only one RUN command.

# Also, note that I included the -y flag for the second command. 
# If I do not include this flag, the image will fail to build 
# when apt-get install prompts the user to confirm their installation. 
# The -y command passes a "yes" response to these prompts.

WORKDIR /home/
# This command changes the working directory of the container.

RUN mkdir data

CMD curl https://en.wikipedia.org/wiki/Whale >> ./data/whale.html
# Because the WORKDIR command specifies that we are working the the /home/
# directory of the container. The CMD above writes google.html to the location
# /home/data/google.html.
