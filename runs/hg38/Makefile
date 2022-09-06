ROOT = ../..
include ${ROOT}/defs.mk


hg38_hub_url_args = $(foreach h,${HG38_HUB_URLS},--huburl=$h)

debug = --debug
# p3debug = --primer3-debug
targets = --target=LDHA+1

done_flag = results/done

specs = specs/human_target_primers.2022-09-03.tsv

all: ${done_flag}

${done_flag}:
	@mkdir -p $(dir $@)
	${primers_juju} ${debug} --conf=specs/config.py design ${p3debug} ${targets} ${hg38_hub_url_args} ${specs} $(dir $@)
	touch $@

clean:
	rm -rf results
