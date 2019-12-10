#!/bin/bash

MD5=$(md5sum requirements.txt | cut -f1 -d' ')
if [[ -d ./.data ]]; then
	echo "There is the .data directory."
else
	mkdir ".data"
	echo "The .data directory is made now."
fi
if [[ -d ./doc ]]; then
	echo "There is the doc directory."
else
	mkdir "doc"
	echo "The doc directory is made now."
fi
if [[ -d ./test ]]; then
	echo "There is the test directory."
else
	mkdir "test"
	echo "The test directory is made now."
fi

export PIPENV_NO_INHERIT=false
export PIPENV_VENV_IN_PROJECT=true

if [[ -f ./.data/ram-$MD5.txt ]]; then
	echo "The packages all installed."
else
	echo "The packages are installed now."
	pyenv local 3.8.0
	rm -rf ./.data/ram-*.txt
	echo $MD5 >./.data/ram-$MD5.txt
	if [[ -d ./.venv ]]; then
		rm -rf .venv/
	fi
	if [[ -f ./Pipfile ]]; then
		rm -rf Pipfile
	fi
	if [[ -f ./Pipfile.lock ]]; then
		rm -rf Pipfile.lock
	fi
	
	pipenv install -r requirements.txt
fi

path="test/test1.py"

pipenv run python3 $path

echo "worked"