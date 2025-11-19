-- Control Tofi with Lua

---escape single quotes for shell usage
---@param str string
---@return string
local escape_shell_arg = function(str)
	return str:gsub("'", "'\\''")
end

---build a tofi command using the given choices and options
---@param choices string[]
---@param options table<string, string | number>
---@return string
local build_tofi_cmd = function(choices, options)
	local parts = {}
	local base_cmd

	-- build the choices string
	if choices then
		-- echo the choices through a pipe to tofi
		local escaped_choices = {}
		for i, choice in ipairs(choices) do
			escaped_choices[i] = escape_shell_arg(choice)
		end
		base_cmd = "echo '" .. table.concat(escaped_choices, "\n") .. "' | tofi"
	else
		-- use drun if no choices given
		base_cmd = "tofi-drun"
	end
	table.insert(parts, base_cmd)

	-- add options to the command if there are any
	if options then
		for option, value in pairs(options) do
			-- convert options from { option = "value" } into "--option='value'"
			local arg = "--" .. option .. "='" .. escape_shell_arg(tostring(value)) .. "'"
			table.insert(parts, arg)
		end
	end

	return table.concat(parts, " ")
end

---execute the command and return its result
---@param command string
---@return string
local execute = function(command)
	local retval = nil
	local handle = io.popen(command)
	if handle then
		retval = handle:read("*a")
		if retval then
			retval = retval:gsub("\n", "")
		end
		handle:close()
	end
	return retval
end

---stores tofi options and choices
---@param choices string[]
---@param options table<string, string | number>
---@return table
local Opener
Opener = function(choi, opts)
	return {
		-- build and execute a tofi command using this opener's parameters
		open = function()
			return execute(build_tofi_cmd(choi, opts))
		end,
		-- get info about the opener
		info = function()
			return { choices = choi, options = opts }
		end,
		-- return a new opener with the new choices
		---@type fun(choices: string[]): table
		choices = function(new_choi)
			return Opener(new_choi, opts)
		end,
		-- return a new opener with the new options
		---@type fun(options: table<string, string | number>): table
		options = function(new_opts)
			return Opener(choi, new_opts)
		end,
	}
end

return Opener(nil, nil)
