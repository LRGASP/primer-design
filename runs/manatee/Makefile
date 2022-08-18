ROOT = ../..
include ${ROOT}/defs.mk


manatee_hub_url_args = $(foreach h,${MANATEE_HUB_URLS},--huburl=$h)
config = specs/config.py
specs = specs/manatee_target_primers_2022-08-18.tsv

#debug = --debug

done_flag = results/done


all: ${done_flag}

${done_flag}:
	@mkdir -p $(dir $@)
	${primers_juju} ${debug} --conf=${config} design ${manatee_hub_url_args} ${specs} $(dir $@)
	touch $@

clean:
	rm -rf results
