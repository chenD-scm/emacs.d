emacs ?= emacs

BASEDIR := $(shell pwd)

install: 
	cd $(BASEDIR)
	git submodule update --init --recursive
	git submodule foreach git reset --hard
	git submodule foreach git checkout master
	make run

pull:
	echo "-*- mode: compilation -*-" > etc/log
	git pull

upgrade: 
	cd $(BASEDIR) && $(emacs) -batch -l packages.el 2>&1 | tee -a etc/log

run:
	$(emacs) -Q -l init.el &

.PHONY: install upgrade run
