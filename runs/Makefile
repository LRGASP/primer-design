ROOT = ..
include ${ROOT}/defs.mk

build: build_hg38 build_manatee
build_%:
	cd $* && ${MAKE}

clean: clean_hg38 clean_manatee
clean_%:
	cd $* && ${MAKE} clean

