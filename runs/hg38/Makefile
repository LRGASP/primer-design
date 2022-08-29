ROOT = ../..
include ${ROOT}/defs.mk


hg38_hub_url_args = $(foreach h,${HG38_HUB_URLS},--huburl=$h)

debug = --debug

done_flag = results/done

specs = specs/human_target_primers.2022-08-28.tsv

all: ${done_flag}

${done_flag}:
	@mkdir -p $(dir $@)
	${primers_juju} ${debug} --conf=specs/config.py design ${hg38_hub_url_args} ${specs} $(dir $@)
	touch $@

clean:
	rm -rf results
