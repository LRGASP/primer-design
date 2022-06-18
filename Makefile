ROOT = .
include ${ROOT}/defs.mk

all:
	@echo "available targets:"
	@echo "  build"
	@echo "  clean"
	@echo "  venv - generate virtual env"
	@exit 1

build:
	cd runs/hg38 && ${MAKE}
	cd hub && ${MAKE}

clean:
	cd runs/hg38 && ${MAKE} clean
	cd hub && ${MAKE} clean


.PHONY: venv
venv:
	test -x ${venv} || ${SYS_PYTHON} -m venv ${venv}
	${PIP} install --upgrade pip
	${PIP} install --upgrade wheel
	${PIP} install --upgrade -e ${primers_juju_dir}
	${PIP} install --upgrade -r ${pycbio}/requirements.txt
	${PIP} install --upgrade -e ${pycbio}




real-clean:
	rm -rf ${venv}
