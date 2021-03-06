maximize = hs.layout.maximized

-- external monitors
benq = hs.screen.find('BenQ')
lg = hs.screen.find('LG')

mash = {
  position = {"ctrl", "alt", "cmd"},
}

-- require('position')

function getPosition(xpadding, ypadding, width, height)
  return {x=xpadding, y=ypadding, w=width, h=height}
end

function bindKeyPosition(key, fn)
  hs.hotkey.bind(mash.position, key, fn)
end

-- reload config automatically
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


bindKeyPosition('o', function()
  hs.application.launchOrFocus("iTerm")
  hs.application.launchOrFocus("Airmail")
  hs.application.launchOrFocus("Firefox")
  hs.application.launchOrFocus("Slack")
  hs.application.launchOrFocus("Visual Studio Code")

  hs.layout.apply({
    {"Airmail", nil, lg, getPosition(0.0, 0.0, 0.40, 0.5), nil, nil},
    {"Slack", nil, lg, getPosition(0.0, 0.5, 0.40, 0.5), nil, nil},
    {"Firefox", nil, lg, getPosition(0.4, 0.0, 0.6, 1.0), nil, nil},
    {"iTerm2", nil, benq, getPosition(0.0, 0.0, 0.5, 1.0), nil, nil},
    {"Code", nil, benq, getPosition(0.5, 0.0, 0.5, 1.0), nil, nil}
  })
end)

bindKeyPosition('h', function()
  hs.hints.windowHints()
end)

-- load spoons
-- hs.loadSpoon("SpoonInstall")
-- hs.loadSpoon("HCalendar")
-- hs.loadSpoon("CircleClock")

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
