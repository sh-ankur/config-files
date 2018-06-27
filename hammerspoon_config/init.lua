--  Screen Names
local retina    = "Color LCD"
local external  = "DELL UP3216Q"

-- Common Applications
local browser   = "Safari"
local email     = "Mail"
local slack     = "Slack"
local iterm     = "iTerm2"
local telegram  = "Telegram Desktop"
local atom      = "Atom"
local trello    = "Trello"
local wunder    = "Wunderlist"
local whatsapp  = "WhatsApp"
local postgres  = "Postgres"


-- Positions
positions = {
  maximized = hs.layout.maximized,
  centered = {x=0.15, y=0.15, w=0.7, h=0.7},

  left25 = {x=0, y=0, w=0.25, h=1},
  left34 = {x=0, y=0, w=0.34, h=1},
  left50 = hs.layout.left50,
  left66 = {x=0, y=0, w=0.66, h=1},
  left75 = {x=0, y=0, w=0.75, h=1},

  right25 = {x=0.75, y=0, w=0.25, h=1},
  right34 = {x=0.66, y=0, w=0.34, h=1},
  right50 = hs.layout.right50,
  right66 = {x=0.34, y=0, w=0.66, h=1},
  right75 = {x=0.25, y=0, w=0.75, h=1},

  upper50 = {x=0, y=0, w=1, h=0.5},
  upper50Left50 = {x=0, y=0, w=0.5, h=0.5},
  upper50Left25 = {x=0, y=0, w=0.25, h=0.5},
  upper50Right50 = {x=0.5, y=0, w=0.5, h=0.5},
  upper50Right25 = {x=0.75, y=0, w=0.25, h=0.5},

  lower50 = {x=0, y=0.5, w=1, h=0.5},
  lower50Left50 = {x=0, y=0.5, w=0.5, h=0.5},
  lower50Left25 = {x=0, y=0.5, w=0.25, h=0.5},
  lower25Left25 = {x=0, y=0.75, w=0.25, h=0.25},
  lower50Right50 = {x=0.5, y=0.5, w=0.5, h=0.5},
  lower50Right25 = {x=0.75, y=0.5, w=0.25, h=0.5},
  lower25Right25 = {x=0.75, y=0.75, w=0.25, h=0.25},

  middle25Left25 = {x=0.0, y=0.50, w=0.25, h=0.25},
  middle25Right25 = {x=0.75, y=0.50, w=0.25, h=0.25},

  middle37 = {x=0.25, y=0, w=0.37, h=1},
  right38 = {x=0.62, y=0, w=0.38, h=1}
}

hs.application.enableSpotlightForNameSearches(true)

local hyper = {"cmd", "alt", "ctrl"}
local mash = {"shift", "ctrl"}

hs.window.animationDuration = 0

-- draw a red border around the active window
function redrawBorder()
    win = hs.window.focusedWindow()
    if win ~= nil then
        top_left = win:topLeft()
        size = win:size()
        if global_border ~= nil then
            global_border:delete()
        end
        global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x'], top_left['y'], size['w'], size['h']))
        global_border:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=0.8})
        global_border:setFill(false)
        global_border:setStrokeWidth(3)
        global_border:show()
    end
end

-- function to open or focus on application
hs.hotkey.bind(hyper, "o", function()
    -- open relevant applications
    hs.application.launchOrFocus(browser)
    hs.application.launchOrFocus(email)
    hs.application.launchOrFocus(telegram)
    hs.application.launchOrFocus(slack)
    hs.application.launchOrFocus("iTerm")

    local officeLayout = {
        {telegram, nil, external,   positions.lower25Left25,     nil,    nil},
        {slack,    nil, external,   positions.middle25Left25,    nil,    nil},
        {email,    nil, external,   positions.upper50Left25,     nil,    nil},
        {iterm,    nil, external,   positions.middle37,           nil,    nil},
        {browser,  nil, external,   positions.right38,         nil,    nil},
    }
    hs.layout.apply(officeLayout)
end)

hs.hotkey.bind(hyper, "h", function()
    -- open relevant applications
    hs.application.launchOrFocus(browser)
    hs.application.launchOrFocus("iTerm")

    local homeLayout = {
        {iterm,    nil, retina,     positions.right50,           nil,    nil},
        {browser,  nil, retina,     positions.left50,            nil,    nil},
    }
    hs.layout.apply(homeLayout)
end)



-- Change app focus
hs.hotkey.bind(hyper, 'up', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowNorth()
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper, 'down', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowSouth()
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper, 'right', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowEast()
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper, 'left', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowWest()
    else
        hs.alert.show("No active window")
    end
end)

-- focus specific apps
-- hs.hotkey.bind(mash, '7', function()
--     hs.application.launchOrFocus(browser)
-- end)

-- hs.hotkey.bind(mash, '8', function()
--     hs.application.launchOrFocus("iTerm2")
-- end)

-- hs.hotkey.bind(mash, '9', function()
--     hs.application.launchOrFocus(email)
-- end)

-- hyper h to show window hints
hs.hotkey.bind(hyper, '.', function()
    hs.hints.windowHints()
end)

-- Load config everytime the config file changes
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- reload the configuration
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()


-- redrawBorder()
