emacs ?= emacs

BASEDIR := $(shell pwd)

install: upgrade
	cd $(BASEDIR)
	make run

pull:
	echo "-*- mode: compilation -*-" > etc/log
	git pull

upgrade: 
	cd $(BASEDIR) && $(emacs) -batch -l packages.el 2>&1 | tee -a etc/log

run:
	$(emacs) -Q -l init.el

.PHONY: install upgrade run
