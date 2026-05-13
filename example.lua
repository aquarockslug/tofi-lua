local tofi = require("tofi")

local selection = tofi
    .options({ width = "33%", height = "33%", anchor = "bottom" })
    .choices({
	    { name = "Apples",  value = "apple" },
	    { name = "Bananas", value = "banana" },
	    "Red",
	    "Yellow",
    })
    .open()

print(selection) -- "apple", "banana", "Red", "Yellow", or nil if cancelled
