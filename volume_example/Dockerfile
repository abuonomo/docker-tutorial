FROM ubuntu

RUN apt-get update &&\
    apt-get install curl
# Notice here that I put both apt-get commands into one RUN command.
# In other words, I did not use the two lines below
# RUN apt-get update
# RUN apt-get install curl
# I put these into one RUN command because each command defines a layer of
# the resultant image. In cases like this, where you are difining the particular set of dependenices, it is best to use only one RUN command.

VOLUME ./data/:/home/data/ 
# Like the COPY command found in python_example/Dockerfile,
# the Volume command also follows the ordering <system> <container>.
# So here we have the definition of a docker volume, a location in the container
# in which data can persist after the stopping or destruction of the container.
# The volume, as defined here, makes it such that the data folder, in
# the directory in which this Dockerfile resides, is synced with the /home/data
# folder inside of the container. Therefore, any changes you make in the system
# folder are reflected in the container's /home/data/ folder and vice-versa.

WORKDIR /home/
# This command changes the working directory of the container.

CMD curl google.com >> ./data/google.html
# Because the WORKDIR command specifies that we are working the the /home/
# directory of the container. The CMD above writes google.html to the location
# /home/data/google.html.
