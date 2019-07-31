#!/bin/bash
set -e

# constants
TEST_FOLDER="$(pwd)/test_mortgage"
DATASET_FOLDER="$TEST_FOLDER/mortgage_dataset"
DATASET_LINK="http://rapidsai-data.s3-website.us-east-2.amazonaws.com/notebook-mortgage-data/mortgage_2000-2001.tgz"
DATASET_NAME="$DATASET_FOLDER/mortgage_2000-2001.tgz"


sudo apt-get update -y
sudo apt-get install gcc g++ -y


mkdir -p $TEST_FOLDER
cd $TEST_FOLDER


if [[ ! "$(command -v conda)" ]]; then
    echo 'conda command was not found in $PATH; attempting to install miniconda to "~/miniconda"'
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda -u
    rm Miniconda3-latest-Linux-x86_64.sh
    export PATH="$HOME/miniconda/bin:$PATH"
    conda init bash
    source ~/miniconda/etc/profile.d/conda.sh
    echo "conda installed to ~/miniconda"
else
    CONDA_BIN=$(which conda)
    CONDA_PROFILE=$(dirname $CONDA_BIN)/../etc/profile.d/conda.sh
    source $CONDA_PROFILE
    echo 'conda found in $PATH'
fi
echo ""


mkdir -p $DATASET_FOLDER
cd $DATASET_FOLDER


if [[ ! -f $DATASET_NAME ]]; then
    echo "$DATASET_NAME file wasn't found"
    echo "downloading it from $DATASET_LINK"
    wget $DATASET_LINK
    tar -xzvf $DATASET_NAME
else
    echo "$DATASET_NAME file was found"
fi
cd ../..

