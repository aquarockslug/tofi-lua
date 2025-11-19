package = "tofi-lua"
version = "0.1.0-1"
source = {
	url = "git://github.com/aquarockslug/tofi-lua",
	tag = "v0.1.0"
}
description = {
	summary = "Control Tofi with Lua",
	detailed = [[
		A Lua wrapper for the tofi menu for Wayland.
		Allows building menus, setting options, and getting results comfortably from Lua.
	]],
	homepage = "https://github.com/aquarockslug/tofi-lua",
	license = "MIT"
}
dependencies = {
	"lua >= 5.1",
}
build = {
	type = "builtin",
	modules = {
		tofi = "tofi.lua"
	}
}
