# tofi-lua

A Lua wrapper for [tofi](https://github.com/philj56/tofi), a dmenu/rofi replacement for Wayland.

## Installation

### LuaRocks

```bash
luarocks install tofi-lua
```

## Usage

```lua
local tofi = require("tofi")

-- Basic usage with options and choices
local menu = tofi
    .options({
        width = "33%",
        height = "33%",
        ["outline-width"] = 4,
        ["prompt-text"] = "Choose:",
        anchor = "center"
    })
    .choices({ "Option A", "Option B", "Option C" })

-- Open the menu and get the result
local result = menu.open()

if result then
    print("You selected: " .. result)
end
```

## API

### `tofi.options(opts)`
Returns a new opener with the specified options.
- `opts`: Table of tofi command line options (e.g., `{ width = "50%", anchor = "top" }`).

### `tofi.choices(items)`
Returns a new opener with the specified choices.
- `items`: Array of strings to display.

### `tofi.open()`
Opens the tofi window. Returns the selected string, or nil/empty string if cancelled.

### `tofi.info()`
Returns a table containing current choices and options.
