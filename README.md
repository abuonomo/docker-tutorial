# Intro

Docker containers enable greater control over project dependencies, increasing portability of software. 

This document is about how to use docker. It does not describe how docker containers work or when to use them.

Clone this repo to run through the example.
I recommend reading the example on the github page because some text have hyperlinks. 

# Table of Contents
1. [Basic](#basics)
2. [Run](#run)
3. [Dockerfile](#dockerfile)
4. [Volumes](#volumes)

## Basics

When using docker, you are primarily dealing with images and containers.

- image: a definition of an environment (including all dependencies)
- container: an ephemeral realization of an image in which some software can run. 

Once a container stops running, all information in it is lost. For example, suppose you use an ubuntu image to make a container in which you run bash. Then you execute:
```
apt-get update
apt-get install curl
```
Hooray. Now you have curl in your container.
Now you exit you container. Then you start it up again. Curl is no long there. 

To list images, run:
```
docker images 
```
To list running containers, run:
```
docker ps
```
To list all containers, run:
```
docker ps -a
```

## Run
Try running:
```
docker run -it ubuntu bash
```

This tells docker to start a container using the ubuntu base image, and to run bash in it. The '-it' flags say that you want to interact with bash inside of the container.

You may notice that you are running as root inside of the container. 
Now exit the container using "exit" or CTRL+D.

Suppose you run:
```
docker run ubuntu bash
```

You may notice that nothing appeared to happen. This is because you told docker to start a container with base image ubuntu, run bash, and then call it a day.

In summary, if you do not specify that you want an interactive session (use -it flags), then the container will only do precisely what you tell it to, and then it will exit.

Now might be a good time to play around with the "docker ps", "docker ps -a" and "docker images" commands.

## Dockerfile

In the previous example we used the ubuntu images which was pulled from docker hub. We can also define our own images using a Dockerfile, like [this one here](python_example/Dockerfile)

The comments in this Dockerfile explain a bit more about how a dockerfile works.

To build the image defined by this Dockerfile, go to the root directory of the dockerfile and run:
```
docker build -t tutorial:latest .
```
This tells docker to build the image from the current directory(Hence the '.'), and to tag it with the name "tutorial" and version "latest". You do not need the -t (tag) flag but it helps to keep things organized. 

Running "docker images" you will see your image created by this Dockerfile. Now try running: 
```
docker run tutorial:latest
```

You should see "yay docker".

You can override the CMD instruction at the end of the Dockerfile by including your down instruction via the command line, for example:
```
docker run tutorial:latest echo 'Bad, docker!'
```

*note: We can run echo because the ENTRYPOINT for the image has defaulted to bash. This need not always be the case. Your ENTRYPOINT could also be python if you wanted it to. Read about ENTRYPOINTS [here](https://docs.docker.com/engine/reference/builder/#entrypoint).*

## Volumes

If you want to exchange data between the docker container and your machine or you want to persist data made in the docker container, use volumes. 

Check out [this Dockerfile](volume_example/Dockerfile).

Now navigate to the volume_example folder and build the image defined therein:
```
docker build -t volume_tutorial .
```
Now enter into the container, and run bash interactively:
```
docker run -it volume_tutorial:latest bash
```
Now, while in the container, navigate to the data folder and write a file there:
```
echo 'persist' > please_persist.txt
```
Now exit your container. Re-enter the container using the 
```
docker run -it volume_tutorial:latest bash
```
Again navigate to the /home/data/ folder (you should be placed in the home directory when you enter the container because of the WORKDIR command in the Dockerfile). You will notice that persist_please.txt is not there. That is because containers are ephemeral. 

Now let's mount a volume to our container so that data will persist. 
You should be in the <project-root>/volume_example/ directory on your system. Now run:
```
docker run -it -v $(pwd)/data/:/home/data/ volume_example:latest bash
```
This commands makes it such that the system's <project_root>/volume_example/data directory and the container's /home/data/ directory are synced up. Changes made in one are reflected in the other. Therefore, changes made in this folder of the container persist after the container has stopped running. 

Navigate to the /home/data/ folder in the container, and notice that sometext.txt is there. This is a file synced from the system's <project_root>/volume_example/data folder.

Now write a file there:
```
echo 'persist, please!' > please_persist.txt
```
Now exit the container and navigate to the synced folder on the system (<project_root>/volume_example/data). You will notice that please_persist.txt is there. 

Now, allow the Dockerfile to run its build in command (defined in Dockerfile) without being overridden by bash (passed on command line).
```
docker run volume_example:latest
```
You will notice that the container executes a curl command. However you navigate to the <project_root>/volume_example/data folder, you will not see the html there. 

Run it again, this time mounting the data folder to a volume:
```
docker run -v $(pwd)/data/:/home/data/ volume_example:latest
```
*Note: we do not need the -it flags because we do not require an interactive session in the container.*

Note that volumes need not be synced with a system folder. You can also make named volumes like so:
```
docker run -v volume_example_volume0:/home/data/ volume_example:latest
```
You will not see whale.html with you navigate to your local data folder, but you will see it when you start the container again and navigate to it's /home/data folder. 
```
docker run -it -v volume_example_volume0:/home/data volume_example:latest bash
cd data
```
Then exit the container.

To see a list of volumes in your docker environment, use:
```
docker volume ls
```

