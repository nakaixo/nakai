SHELL := /bin/bash
DENO ?= $(shell which deno)
GLEAM ?= $(shell which gleam)

.PHONY: codegen gleam_build

all: codegen gleam_build

codegen:
	@$(DENO) run --allow-read --allow-write ./codegen/gen.ts

gleam_build: codegen
	@$(GLEAM) build
