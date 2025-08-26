#!/bin/bash

echo -e "Running all helpers... \n"

./helpers/1-clean.sh
./helpers/2-flatten.sh
./helpers/3-build-flat.sh
./helpers/4-build-src.sh
./helpers/5-build-test.sh
./helpers/6-build-script.sh

echo -e "All helpers completed. \n"