BUILD_DIR?=dist
BUILD?=$(BUILD_DIR)/$(BUILD_PREFIX)/$(OUT)
.PHONY:build
build: $(BUILD_DIR)/$(BUILD_PREFIX) $(BUILD)

$(BUILD_DIR)/$(BUILD_PREFIX): $(BUILD_DIR)

$(BUILD_DIR)/$(BUILD_PREFIX) $(BUILD_DIR):
	@mkdir -p $@

$(BUILD): $(DEPS)
