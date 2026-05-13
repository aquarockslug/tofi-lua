# tofi-lua

Lua bindings for [tofi](https://github.com/philj56/tofi).

```lua
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
```

## API

`require("tofi")` returns an **opener** with these methods:

- `.options({...})` — set tofi flags (e.g. `["outline-width"] = 4`, `["prompt-text"] = "Choose:"`). Returns a new opener.
- `.choices({...})` — set menu entries. Entries can be strings or `{name, value}` tables. Returns a new opener.
- `.open()` — launch tofi, return the selected value, or `nil` if cancelled.
- `.info()` — return `{choices = ..., options = ...}` for debugging.

If no choices are given, `tofi-drun` is used instead.
