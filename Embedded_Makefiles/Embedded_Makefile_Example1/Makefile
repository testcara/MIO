.PHONY : all
all: build

build:
	@echo "---> Start to make ..."
	@make build_web
	@make build_api
	@echo "---> Done to make ..."
include ./WEB/WEB_Makefile 
include ./API/API_Makefile