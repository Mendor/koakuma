ERLC=`which erlc`
ERL=`which erl`
EBIN_DIR=ebin
EUNIT_DIR=eunit
TESTED_MODULES=koakuma_cfg, koakuma_bot, koakuma_queue
.DEFAULT_GOAL := compile
.PHONY: compile clean test

compile:
	mkdir -p $(EBIN_DIR)
	$(ERLC) -I include -o $(EBIN_DIR) src/*.erl

clean:
	rm -rf $(EBIN_DIR)/*.beam $(EUNIT_DIR)

test:
	mkdir -p $(EUNIT_DIR)
	$(ERLC) +export_all -I include -o $(EUNIT_DIR) src/*.erl test/*.erl -DTEST
	$(ERL) -noshell -pa $(EUNIT_DIR) -eval "eunit:test([$(TESTED_MODULES)], [verbose])" -s init stop
