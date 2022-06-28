ROOT = ../..
include ${ROOT}/defs.mk


hg38_hub_url_args = $(foreach h,${HG38_HUB_URLS},--huburl=$h)

debug = --debug

done_flag = results/done

all: ${done_flag}

${done_flag}:
	@mkdir -p $(dir $@)
	${primers_juju} ${debug} --conf=specs/config.py design ${hg38_hub_url_args} specs/LRGASP_WTC11_Target_set1.tsv $(dir $@)
	touch $@

clean:
	rm -rf results
