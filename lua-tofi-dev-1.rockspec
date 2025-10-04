package = "tofi-lua"
version = "dev-1"
source = {
	url = "git+ssh://git@github.com/aquarockslug/tofi-lua.git"
}
description = {
	summary = "Control Tofi with Lua",
	homepage = "github.com/aquarockslug/tofi-lua",
	license = "MIT"
}
dependencies = {
	"lua >= 5.1, < 5.4",
}
build_dependencies = {
	queries = {}
}
build = {
	type = "builtin",
	modules = {
		tofi = "tofi.lua",
	}
}
