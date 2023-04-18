SHELL := /bin/bash
DENO ?= $(shell which deno)
GLEAM ?= $(shell which gleam)

.PHONY: codegen gleam_build

all: codegen gleam_build

codegen: | src/nakai/html/
	@$(DENO) run --allow-read --allow-write ./codegen/gen.ts

gleam_build: codegen
	@$(GLEAM) build

src/nakai/html/:
	@mkdir -p src/nakai/html/
