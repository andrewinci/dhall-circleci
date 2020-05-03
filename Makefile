SOURCES:=$(wildcard schema/*.dhall)
TESTS:=$(wildcard tests/*)

build:
	dhall-to-yaml-ng --explain  --file example/main.dhall

.PHONY: tests/* schema/*

test: $(TESTS)
format: $(SOURCES)

tests/*:
	dhall-to-yaml-ng --file $@
	dhall-to-yaml-ng --file $@ | circleci config validate -

schema/*:
	dhall lint --inplace $@
	dhall format --inplace $@
