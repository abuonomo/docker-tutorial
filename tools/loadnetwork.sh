#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied."
    exit
fi

network=${1%%.*}
if [ -d "$network" ]; then
    echo -n "Already have folder in local dir named ${network}." 
    exit
fi
mkdir $network

echo -e "Restoring docker network..."
echo -e "   Gunzipping and unarchiving..."
tar -zxvf "${network}.tar.gz"

echo -e "   Restoring volumes..."
for volume in $(ls "${network}/volumes/")
do  
    docker run --rm \
        -v ${volume%.tar}:/volume \
        -v "$(pwd)/${network}/volumes/${volume}:/backup/${volume}" \
        busybox \
        tar -xvf "/backup/${volume}" -C "/"
done

echo -e "   Restoring images"
docker image load -i "${network}/${network}_images.tar"

echo "Cleaning up..."
rm -r ${network}
# rm "${network}.tar"
echo "Cleaned."

echo -e "Done"