.PHONY : all
all: build

export VAR_1 = 'exported'
VAR_2 = 'have not exported'
build:
	@echo "---> Start to make ..."
	@echo "---> Output VAR_1 & VAR_2 ..."
	@echo VAR_1: ${VAR_1}
	@echo VAR_2: ${VAR_2}
	@make build_web
	@make build_api
	@echo "---> Done to make ..."
include ./WEB/WEB_Makefile 
include ./API/API_Makefile