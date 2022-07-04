ROOT = ..
include ${ROOT}/defs.mk

hubUrl = https://hgwdev.gi.ucsc.edu/~markd/lrgasp/juju-hub/hub.txt

chromAlias_hg38 = https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.chromAlias.bb

all: build
	hubCheck ${hubUrl}

build: ${genomes:%=build_%}
build_%:
	${MAKE} genome_build genome=$*

clean: ${genomes:%=clean_%}
clean_%:
	${MAKE} genome_clean genome=$*


##
# recurisve  genome=
##
juju_output_dir = ../runs/${genome}/results
chromAlias = ${chromAlias_${genome}}

bigBeds = ${genome}/primers.bb ${genome}/targets.bb ${genome}/genome-uniqueness.bb ${genome}/transcriptome-uniqueness.bb
beds = $(foreach b,$(basename ${bigBeds}),${b}.bed)
juju_designs_tsv = ${genome}/juju_designs.${genome}.tsv
juju_designs_xslt = ${genome}/juju_designs.${genome}.xslt
annotated_rna_fa = ${genome}/annotated_rna.${genome}.fa

define cat_beds =
test -n "$^" || (echo "No input files found" >&2 ; exit 1)
sort -k 1,1 -k2,2n $^ >$@.tmp
mv -f $@.tmp $@
endef

genome_build: ${bigBeds} ${juju_designs_tsv} ${annotated_rna_fa}

${genome}/primers.bed: ${juju_output_dir}/*/*.primers.bed
	${cat_beds}

${genome}/primers.bb: ${genome}/primers.bed
	bedToBigBed -tab -type=bed12+ -as=${primers_juju_dir}/etc/bigPrimerBed.as -sizesIsBb -extraIndex=name $< ${chromAlias} $@.tmp
	mv $@.tmp $@

${genome}/targets.bed: ${juju_output_dir}/*/*.target.bed
	${cat_beds}

${genome}/targets.bb: ${genome}/targets.bed
	bedToBigBed -tab -type=bed12 -sizesIsBb -extraIndex=name $< ${chromAlias} $@.tmp
	mv $@.tmp $@

${genome}/genome-uniqueness.bed: ${juju_output_dir}/*/*.genome-uniqueness.bed
	${cat_beds}

${genome}/genome-uniqueness.bb: ${genome}/genome-uniqueness.bed
	bedToBigBed -tab -type=bed12 -sizesIsBb -extraIndex=name $< ${chromAlias} $@.tmp
	mv $@.tmp $@

${genome}/transcriptome-uniqueness.bed: ${juju_output_dir}/*/*.transcriptome-uniqueness.bed
	${cat_beds}

${genome}/transcriptome-uniqueness.bb: ${genome}/transcriptome-uniqueness.bed
	bedToBigBed -tab -type=bed12 -sizesIsBb -extraIndex=name $< ${chromAlias} $@.tmp
	mv $@.tmp $@

${juju_designs_tsv}: ${juju_output_dir}/*/*.designs.tsv
	tawk '(NR == 1) || (FNR > 1)' $^ >$@

${annotated_rna_fa}: ${juju_output_dir}/*/*.debug.txt
	awk '/^target_id/{print ">"$$2} /^annotated_rna/{print $$2}' $^ >$@

genome_clean:
	rm -f ${beds} ${bigBeds} ${juju_designs_tsv}