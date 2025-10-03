local tofi = require("tofi")

local menu = tofi
    .options({
	    width = "33%",
	    height = "33%",
	    ["outline-width"] = 4,
	    ["prompt-text"] = "󰈿_",
	    ["text-cursor"] = "true",
	    ["result-spacing"] = 9,
	    anchor = "bottom",
	    ["margin-bottom"] = 10
    })
    .choices({ "a", "b", "c" })

local result = menu.open()

print(result)
