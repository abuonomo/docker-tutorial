# Intro

Docker containers enable greater control over project dependencies, increasing portability of software. 

This document is about how to use docker. It does not describe how docker containers work or when to use them.

Clone this repo to run through the example.

# Table of Contents
1. [Basic](#basics)
2. [Run](#run)
2. [Dockerfile](#dockerfile)

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

In the previous example we used the ubuntu images which was pulled from docker hub. We can also define our own images using a Dockerfile. See here: [a relative link](./example/Dockerfile)

