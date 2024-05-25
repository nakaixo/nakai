SHELL := /bin/bash
GLEAM ?= gleam


all: build
.PHONY: all

# `gleam run -m ...` does a full build, but we need to run it again after our codegen
# step, or we might end up with the build artifacts being stale, if the new generated
# is different.
build: codegen
	@$(GLEAM) build
.PHONY: build

codegen:
	@$(GLEAM) run -m nakai_codegen
.PHONY: codegen

docs: codegen
	@$(GLEAM) docs build
.PHONY: docs

format:
	@$(GLEAM) format
	@$(GLEAM) run -m nakai_codegen
.PHONY: format

test: codegen
	@$(GLEAM) test
.PHONY: test

bench: codegen
	@$(GLEAM) run -m nakai_benchmark
.PHONY: bench

clean:
	@$(GLEAM) clean
.PHONY: clean
