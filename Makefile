## Makefile for ycbm/riot

js/riot-tags.js: tags/*.tag
	riot tags $@
