# The default goal/target to run when no parameters are passed in
.DEFAULT_GOAL := test
# Targets that don't produce files and should not be associated with a file
.PHONY: test lint fmt

fmt:
	stylua --color always .

lint: fmt
	luacheck lua/ tests/

test: lint
	nvim --headless  -u tests/init.lua -c "PlenaryBustedDirectory tests/ { minimal_init = './tests/init.lua' }"
