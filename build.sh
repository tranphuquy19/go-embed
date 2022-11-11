#!/bin/bash

# Author: tranphuquy19@gmail.com

PLATFORMS_FILE_ARGUMENT=$1
PLATFORMS_FILE="${PLATFORMS_FILE_ARGUMENT:-platforms.txt}"
WORKING_DIR="${PWD}"
FULL_PATH_PLATFORMS_FILE=$WORKING_DIR/$PLATFORMS_FILE
APP_NAME=go-embed

# check file platforms.txt
if [ ! -f $FULL_PATH_PLATFORMS_FILE ]; then
    echo "Platforms file: $FULL_PATH_PLATFORMS_FILE does not exist"
    exit 1
fi

# remove build folder
echo "Clean build folder"
rm -rf ./build

# create build folder
echo "Create build folder"
mkdir -p build

# install dependencies
echo "Install dependencies"
go mod download

# read platforms file
while read line; do
    temp=(${line//\// })

    GOOS=${temp[0]}
    GOARCH=${temp[1]}

    output_name=$APP_NAME

    if [ $GOOS = "windows" ]; then
        output_name+='.exe'
    fi

    mkdir -p build/$GOOS/$GOARCH
    output_path="$WORKING_DIR/build/$GOOS/$GOARCH/$output_name"

    echo "===================================================="
    echo "Building for OS=$GOOS Architecture=$GOARCH" 
    
    env GOOS=$GOOS GOARCH=$GOARCH go build -ldflags="-s -w" -o $output_path

    if [ ! -f $output_path ]; then
        echo "Failed when build for OS=$GOOS Architecture=$GOARCH"
        exit 1
    else
        fileSize=$(find "$output_path" -printf "%s")
        echo "Done with output file: $output_path ($fileSize bytes)"
    fi

    if [ $? -ne 0 ]; then
        echo 'An error has occurred! Aborting the script execution...'
        exit 1
    fi
done < $PLATFORMS_FILE

# Clean task
# echo "Clean build"
# go mod tidy
# rm -rf ./build

echo "DONE"