SOURCES:=$(wildcard */*.dhall *.dhall)

build:
	dhall-to-yaml-ng --explain  --file example/main.dhall

.PHONY: $(SOURCES)
format: $(SOURCES)

$(SOURCES):
	dhall lint --inplace $@
	dhall format --inplace $@
