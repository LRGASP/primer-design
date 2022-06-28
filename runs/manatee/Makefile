ROOT = ../..
include ${ROOT}/defs.mk


manatee_hub_url_args = $(foreach h,${MANATEE_HUB_URLS},--huburl=$h)

#debug = --debug

done_flag = results/done


all: ${done_flag}

${done_flag}:
	@mkdir -p $(dir $@)
	${primers_juju} ${debug} --conf=specs/config.py design ${manatee_hub_url_args} specs/manatee_target_primers_062322.txt $(dir $@)
	touch $@

clean:
	rm -rf results
