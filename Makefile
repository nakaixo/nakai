SHELL := /bin/bash
GLEAM ?= $(shell which gleam)


all: build
.PHONY: all

build: codegen
	@$(GLEAM) build
.PHONY: build

codegen: \
	./src/nakai/html.gleam \
	./src/nakai/html/attrs.gleam
.PHONY: codegen

./src/nakai/html.gleam: ./src/nakai/codegen/html.gleam
	@$(GLEAM) run -m nakai/codegen/html

./src/nakai/html/attrs.gleam: ./src/nakai/codegen/attrs.gleam
	@$(GLEAM) run -m nakai/codegen/attrs
