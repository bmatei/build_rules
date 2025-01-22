PACKAGE_NAME=build-rules
VERSION=$(shell ./genver.sh)

MODULES=$(wildcard tests/*/)

BUILD_PREFIX=var/lib/build_rules
BUILD_DIR=dist
CLEAN_TARGETS=$(BUILD_DIR)
SRC=$(wildcard *.mk) interfaces templates features
BUILD=$(addprefix $(BUILD_DIR)/$(BUILD_PREFIX)/,$(SRC))
SCRIPTS_DIR=$(BUILD_DIR)/usr/local/bin
SETUP_SCRIPT=$(SCRIPTS_DIR)/build-rules-setup.sh

.PHONY: all
all: build deploy-debian

include build_rules/features/deploy/debian.mk
CLEAN_TARGETS+=$(DEBIAN_TARGET) $(DEBIAN_TARGET).deb

.PHONY:build
build: all-tests $(BUILD_DIR) $(BUILD) $(SETUP_SCRIPT)

.PHONY:all-tests
all-tests: MAKECMDGOALS=all-tests
all-tests: $(MODULES)

.PHONY: $(MODULES)
$(MODULES):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY:docs
docs:
include build_rules/interfaces/clean.mk

$(BUILD_DIR): $(BUILD_DIR)/$(BUILD_PREFIX) $(SCRIPTS_DIR)

$(BUILD_DIR)/$(BUILD_PREFIX) $(SCRIPTS_DIR):
	@mkdir -pv $@

$(BUILD) $(SETUP_SCRIPT):
	cp -Rv "$(shell basename $@)" "$(shell dirname $@)"
