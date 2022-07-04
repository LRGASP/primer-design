ROOT = ..
include ${ROOT}/defs.mk

build: ${genomes:%=build_%}
build_%:
	cd $* && ${MAKE}

clean: ${genomes:%=clean_%}
clean_%:
	cd $* && ${MAKE} clean

