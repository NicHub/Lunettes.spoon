--- === Lunettes ===
local obj = {}
obj.__index = obj

--- Metadata
obj.name = "Lunettes"
obj.version = "0.3.1"
obj.author = "Scott Hudson <scott.w.hudson@gmail.com>"
obj.license = "MIT"
obj.homepage = "https://github.com/NicHub/Lunettes.spoon.git"

--- disable animation
hs.window.animationDuration = 0

--- Internal function used to find our location, so we know where to load files from
local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end
obj.spoonPath = script_path()

obj.Command = dofile(obj.spoonPath .. "src/command.lua")
obj.history = dofile(obj.spoonPath .. "src/history.lua"):init()

obj.defaultHotkeys = {
  leftHalf = {
    { { "ctrl", "alt" }, "left" },
  },
  rightHalf = {
    { { "ctrl", "alt" }, "right" },
  },
  topHalf = {
    { { "ctrl", "alt" }, "up" },
  },
  bottomHalf = {
    { { "ctrl", "alt" }, "down" },
  },
  topLeft = {
    { { "ctrl", "alt" }, "U" },
  },
  topRight = {
    { { "ctrl", "alt" }, "I" },
  },
  bottomLeft = {
    { { "ctrl", "alt" }, "J" },
  },
  bottomRight = {
    { { "ctrl", "alt" }, "K" },
  },
  fullScreen = {
    { { "ctrl", "alt" }, "Return" },
  },
  center = {
    { { "ctrl", "alt" }, "C" },
  },
  nextThird = {
    { { "ctrl", "alt" }, "Right" },
  },
  prevThird = {
    { { "ctrl", "alt" }, "Left" },
  },
  enlarge = {
    { { "ctrl", "alt", "shift" }, "Right" },
  },
  shrink = {
    { { "ctrl", "alt", "shift" }, "Left" },
  },
  undo = {
    { { "alt", "cmd" }, "Z" },
  },
  redo = {
    { { "alt", "cmd", "shift" }, "Z" },
  },
  nextDisplay = {
    { { "ctrl", "alt", "cmd" }, "Right" },
  },
  prevDisplay = {
    { { "ctrl", "alt", "cmd" }, "Left" },
  }
}

function obj:bindHotkeys(userBindings)
  print("Lunettes: Binding Hotkeys")

  local userBindings = userBindings or {}
  local bindings = self.defaultHotkeys

  for command, mappings in pairs(userBindings) do
    bindings[command] = mappings
  end

  for command, mappings in pairs(bindings) do
    if mappings then
      for i, binding in ipairs(mappings) do
        hs.hotkey.bind(binding[1], binding[2], function()
          self:exec(command)
        end)
      end
    end
  end
end

function obj:exec(commandName)
  local window = hs.window.focusedWindow()
  local windowFrame = window:frame()
  local screen = window:screen()
  local screenFrame = screen:frame()
  local currentFrame = window:frame()
  local newFrame

  if commandName == "undo" then
    newFrame = self.history:retrievePrevState()
  elseif commandName == "redo" then
    newFrame = self.history:retrieveNextState()
  else
    print("Lunettes: " .. commandName)
    print(self.Command[commandName])
    newFrame = self.Command[commandName](windowFrame, screenFrame)
    self.history:push(currentFrame, newFrame)
  end

  window:setFrame(newFrame)
end

return obj
