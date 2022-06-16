ROOT = ../..
include ${ROOT}/defs.mk


hg38_hub_url_args = $(foreach h,${HUB_URLS},--huburl=$h)

WTC11_set1_done = results/WTC11_set1.done

done_flags = ${WTC11_set1_done}

all: ${done_flags}

${WTC11_set1_done}:
	@mkdir -p $(dir $@)
	${primers_juju} --conf=specs/config.py design ${hg38_hub_url_args} specs/LRGASP_WTC11_Target_set1.tsv $(dir $@)
	touch $@

clean:
	rm -rf results
