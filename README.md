# LUNETTES

Lunettes is a fork of [Lunettes].

[Lunettes]: https://github.com/scottwhudson/Lunettes

It is a window manager based on [Hammerspoon].

[Hammerspoon]: https://www.hammerspoon.org/

The keybindings are mostly those of [Rectangle.app].

[Rectangle.app]: https://rectangleapp.com/

## Installation

Clone it as a Git submodule :

```bash
cd $HOME/.hammerspoon/Spoons/
git submodule add https://github.com/NicHub/Lunettes.spoon.git
````

And modify `$HOME/.hammerspoon/Spoons/init.lua` :

```lua
--[[
    Lunettes
    https://github.com/NicHub/Lunettes.spoon
--]]
hs.spoons.use("Lunettes", { hotkeys = "default" })
```
