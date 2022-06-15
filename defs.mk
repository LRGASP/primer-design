MAKEFLAGS = --no-builtin-rules
SHELL = /bin/bash

pycbio = ${HOME}/compbio/code/pycbio

primers_juju_dir = ${ROOT}/../PrimerS-JuJu

venv = ${ROOT}/venv
venv_act = source ${venv}/bin/activate

SYS_PYTHON = python3
PYTHON = ${venv_act} && python3
PIP = ${PYTHON} -m pip

primers_juju = ${venv_act} && ${primers_juju_dir}/bin/primers-juju
