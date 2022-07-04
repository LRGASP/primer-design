MAKEFLAGS = --no-builtin-rules
SHELL = /bin/bash
.SECONDARY:

#genomes = hg38 manatee
genomes = hg38

HG38_LRGASP_HUB_URL = http://conesalab.org/LRGASP/LRGASP_hub/hub.txt
MANATEE_LRGASP_HUB_URL = http://conesalab.org/LRGASP/LRGASP_manatee_hub/manatee/hub.txt
JUJU_HUB_URL = https://hgwdev.gi.ucsc.edu/~markd/lrgasp/juju-hub/hub.txt

HG38_HUB_URLS = ${HG38_LRGASP_HUB_URL} ${JUJU_HUB_URL}
MANATEE_HUB_URLS = ${MANATEE_LRGASP_HUB_URL} ${JUJU_HUB_URL}

pycbio = ${HOME}/compbio/code/pycbio

primers_juju_dir = ${ROOT}/../PrimerS-JuJu

venv = ${ROOT}/venv
venv_act = source ${venv}/bin/activate

SYS_PYTHON = python3
PYTHON = ${venv_act} && python3
PIP = ${PYTHON} -m pip

primers_juju = ${venv_act} && ${primers_juju_dir}/bin/primers-juju
