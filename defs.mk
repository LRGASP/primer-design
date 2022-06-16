MAKEFLAGS = --no-builtin-rules
SHELL = /bin/bash
.SECONDARY:

LRGASP_HUB_URL = http://conesalab.org/LRGASP/LRGASP_hub/hub.txt
JUJU_HUB_URL = https://hgwdev.gi.ucsc.edu/~markd/lrgasp/juju-hub/hub.txt

HUB_URLS = ${LRGASP_HUB_URL} ${JUJU_HUB_URL}

pycbio = ${HOME}/compbio/code/pycbio

primers_juju_dir = ${ROOT}/../PrimerS-JuJu

venv = ${ROOT}/venv
venv_act = source ${venv}/bin/activate

SYS_PYTHON = python3
PYTHON = ${venv_act} && python3
PIP = ${PYTHON} -m pip

primers_juju = ${venv_act} && ${primers_juju_dir}/bin/primers-juju
