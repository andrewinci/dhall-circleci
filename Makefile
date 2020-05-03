SOURCES:=$(wildcard schema/*.dhall)
TESTS:=$(wildcard tests/*)

.PHONY: tests/* schema/*

config:
	dhall lint --inplace .circleci/config.dhall
	dhall-to-yaml-ng --file .circleci/config.dhall > .circleci/config.yml

test: $(TESTS)
format: $(SOURCES)

tests/*:
	dhall-to-yaml-ng --file $@
	dhall-to-yaml-ng --file $@ | circleci config validate -

schema/*:
	dhall lint --inplace $@
	dhall format --inplace $@
