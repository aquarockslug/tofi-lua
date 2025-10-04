-- Control Tofi with Lua

--[[
returns a table containing four functions:
	- options({ option = value })
	- choices({ choice1, choice2})
	- info()
	- open()
uses drun if no choices are given

Usage example:
local my_opener = require("tofi").options({ option = value})
my_opener.choices({"a", "b", "c"}).open()
]]

-- build a tofi command using the given choices and options
local build_tofi_cmd = function(choices, options)
	local cmd = ""

	-- build the choices string
	if choices then
		cmd = "echo '"
		for _, choice in ipairs(choices) do
			cmd = cmd .. choice .. "\n"
		end
		cmd = cmd .. "' | tofi "
	else
		cmd = "tofi-drun "
	end

	-- add options to the command if there are any
	if options then
		for option, value in pairs(options) do
			-- convert options from { option = "value" } into "--option=value"
			local arg = "--" .. option .. "=" .. value
			-- add the argument to the command
			cmd = cmd .. " " .. arg
		end
	end

	return cmd
end

-- execute the command and return its result
local execute_tofi = function(command)
	local retval = ""
	local handle = io.popen(command)
	if handle then
		retval = handle:read("*a"):gsub("\n", "")
		handle:close()
	end
	return retval
end

-- for controlling tofi options and choices
Opener = function(choi, opts)
	return {
		-- build and execute a tofi command using this opener's parameters
		open = function()
			local cmd = build_tofi_cmd(choi, opts)
			return execute_tofi(cmd)
		end,
		-- get info about the opener
		info = function()
			return { choices = choi, options = opts }
		end,
		-- return a new opener with the new choices
		choices = function(new_choi)
			return Opener(new_choi, opts)
		end,
		-- return a new opener with the new options
		options = function(new_opts)
			return Opener(choi, new_opts)
		end,
	}
end

return Opener(nil, nil)
