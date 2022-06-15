ROOT = .
include ${ROOT}/defs.mk


all:
	@echo "available targets:"
	@echo "  venv - generate virtual env"
	@exit 1


.PHONY: venv
venv:
	test -x ${venv} || ${SYS_PYTHON} -m venv ${venv}
	${PIP} install --upgrade pip
	${PIP} install --upgrade wheel
	${PIP} install --upgrade -r ${primers_juju_dir}/requirements-dev.txt
	${PIP} install --upgrade -r ${pycbio}/requirements.txt
	${PIP} install --upgrade -e ${pycbio}




real-clean:
	rm -rf ${venv}
