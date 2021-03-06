#!/bin/bash
set -e

# prepare conda tool, mortgage dataset
source ./prereq_install.sh

conda env list | grep -q mortgage_cpu || conda env create -f requirements_cpu.yml
echo "env mortgage_cpu is created"

conda activate mortgage_cpu
echo "mortgage_cpu is activated"


# for build pandas from source uncomment the block below and
# add next lines to 'requirements_cpu.yml':
# - cython
# - numpy=1.16.2

# git clone https://github.com/pandas-dev/pandas.git && cd pandas
#
# echo "building pandas from master"
# python setup.py install
# echo "build successful"


cd `dirname $0`

echo ''
echo -------------/ Measuring with DAAL4PY /-------------
echo ''
time python mortgage_pandas.py $DATASET_FOLDER 1 daal

echo ''
echo -------------/ Measuring with XGBoost /-------------
echo ''
time python mortgage_pandas.py $DATASET_FOLDER 1 xgb

