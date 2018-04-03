# Each lines in this Dockerfile defines a layer of the resultant image.
# I won't delve into what exactly this means here. 

FROM python
# Here the base image python is defined we could also be more specific and write:
# FROM python:3.6.1

COPY requirements.txt /home/requirements.txt
# Here we take the requirements file in the folder in which this Dockerfile resides
# and copy it to the /home/requirements.txt location in the docker container 
# (which would be built from the image made by this file). 
# Note the ordering here: COPY <system location> <container location>. This ordering is used for most (maybe all) docker commands which require reference to parallel attributes of the system and the container.

RUN pip install -r /home/requirements.txt
# And we run the given command to install packages from the requirements file. 
# NOTE: RUN creates a layer of the image. 
# This command, for example, creates a layer of all the dependencies from the requirements file. 
# If you were to make another image based on python which used the same requirements file, it would use the same image layer 
# (thereby minimizing image bloat).

CMD echo "yay docker"
# CMD is different from RUN. CMD executes a command from in the container with the image define.
# RUN commands are for setting up the environment. 
# CMD is where you actually execute the primary purpose of your container. 
