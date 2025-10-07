-- Little script for testing Lua integration

local value = 10 + 20

core.print('Hello world! ', value)
core.warning('This is a warning, oh no!')
core.error(false, 'Error!')

core.print('Engine version is ', core.VERSION_MAJOR, '.', core.VERSION_MINOR)
