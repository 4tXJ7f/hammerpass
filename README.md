# hammerpass

A simple [Hammerspoon](http://www.hammerspoon.org/) script for the [pass](https://www.passwordstore.org/) password manager.

## Install

1. Clone repository
2. Create link to `pass.lua` in `~/.hammerspoon`: `ln -s <PATH_TO_HAMMERPASS>/pass.lua ~/.hammerspoon/pass.lua`
3. Change `~/.hammerspoon/init.lua` to call hammerpass

## Example

Basic `init.lua` that calls hammerpass:

```
require("pass")
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "P", choose_password)
```
