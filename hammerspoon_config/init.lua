
maximize = hs.layout.maximized

-- external monitors
benq = hs.screen.find('BenQ')
dell = hs.screen.find('DELL')

mash = {
  position = {"ctrl", "alt", "cmd"},
}

require('position')

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
  hs.application.launchOrFocus("Safari")
  hs.application.launchOrFocus("Mail")
  hs.application.launchOrFocus("Spotify")
  hs.application.launchOrFocus("Firefox")
  hs.application.launchOrFocus("Slack")
  hs.application.launchOrFocus("Telegram")

  hs.layout.apply({
    {"Safari", nil, benq, getPosition(0.5, 0.0, 0.5, 1.0), nil, nil},
    {"Mail", nil, benq, getPosition(0.0, 0.0, 0.25, 0.5), nil, nil},
    {"Slack", nil, benq, getPosition(0.0, 0.5, 0.25, 0.5), nil, nil},
    {"Spotify", nil, benq, getPosition(0.25, 0.0, 0.25, 0.5), nil, nil},
    {"Telegram", nil, benq, getPosition(0.25, 0.5, 0.25, 0.5), nil, nil},
    {"iTerm2", nil, dell, getPosition(0.0, 0.0, 0.65, 1.0), nil, nil},
    {"Firefox", nil, dell, getPosition(0.65, 0.0, 0.35, 1.0), nil, nil}
  })
end)

bindKeyPosition('h', function()
  hs.hints.windowHints()
end)

-- load spoons
hs.loadSpoon("SpoonInstall")
hs.loadSpoon("HCalendar")
hs.loadSpoon("CircleClock")

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
