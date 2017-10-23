#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi

network=$1
if [ -d "$network" ]; then
    echo -n "Already have folder in local dir named ${network}." 
    exit
fi
mkdir $network

echo "Compressing $network .\n"

images=$(docker images --format "{{.Repository}}" | grep "$network"_)
volumes=$(docker volume ls --format "{{.Name}}" | grep "$network"_)

echo -e "Images\n------"
echo -e $images

echo -e "Volumes\n-------"
echo -e $volumes

echo "Do you wish to compress these images and volumes?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo "Compressing images.."
docker save $images -o "${network}/${network}_images.tar"
echo "Compressed images."

echo "Compressing volumes..."

for volume in $volumes
do  
    docker run --rm \
        -v $volume:/volume \
        -v "$(pwd)/${network}/volumes/:/backup" \
        busybox \
        tar cvf "/backup/$volume.tar" volume
done
echo "Compressed volumes."

echo "Compressing ${network}..."
tar cvf  "${network}.tar" ${network}
echo "Compressed ${network}."
