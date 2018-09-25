-- Imports
require "inc/battery"
require "inc/noises"
require "inc/vpn"
require "inc/mikrotik"
require "inc/caffeine"
popclickInit()


-- None of this animation shit:
hs.window.animationDuration = 0

-- Trigger existing hyper key shortcuts
local hyper     = {"cmd", "alt", "ctrl", "shift" }
local mash     	= {"cmd", "alt" }

---------------- OGOLE HISTORIE --------------------
local laptopScreen = "Color LCD"
-- szerokosc ekranu
local screenWidth = hs.screen.primaryScreen():currentMode().w
-- wysokosc ekranu
local screenHeight = hs.screen.primaryScreen():currentMode().h


-- Uruchomienie consoli Hammerspoona
hs.hotkey.bind(hyper, "D", function()
	hs.toggleConsole(true)
end)

-- Aktualne okno na cały ekran
hs.hotkey.bind(hyper, "M", function()
	hs.window.focusedWindow():maximize()
end)

-- Lewo / Prawo dla Findera
hs.hotkey.bind(hyper, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)
hs.hotkey.bind(hyper, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- ================ SOUL OF NEW MACHINE START ====================================================
function open_menu(app)
    local appName = hs.appfinder.appFromName(app)
    local str_default = ""
	hs.alert.show(app)
    if (app == "LibreOffice") then
	    str_default = {"File", "Recent Documents", "1. Dusza-nowej-maszyny.odt"}
    elseif (app == "iBooks") then
	    str_default = {"File", "Open Recent", "The Soul of a New Machine"}
    elseif (app == "Safari") then
	    str_default = {"Bookmarks", "Favorites", "SoulMachine", "Open in New Tabs"}
    end
--hs.alert.show(str_default)
    appName:selectMenuItem(str_default)
end

local windowLayout = {
	{"LibreOffice",	nil,	laptopScreen,	hs.layout.left50,   nil, nil},
	{"iBooks",	nil,	laptopScreen,	nil, nil, hs.geometry.rect(screenWidth/2, 0, screenWidth/2, screenHeight/2 )},
	{"Safari",	nil,	laptopScreen,	nil, nil, hs.geometry.rect(screenWidth/2, screenHeight/2+100, screenWidth/2, screenHeight/2-100 )},
}
hs.hotkey.bind(hyper, "P", function()
--	hs.application.launchOrFocus("LibreOffice")
	os.execute("~/bin/soul.sh &")
--	os.execute("~/bin/soul-ibooks.sh &")
	os.execute("~/bin/soul-ade.sh &")
--	hs.application.launchOrFocus("iBooks")
	hs.application.launchOrFocus("Safari")
	hs.layout.apply(windowLayout)
	hs.timer.usleep(5000)
--	open_menu("LibreOffice")
	open_menu("iBooks")
	open_menu("Safari")
end)

-- ================ SOUL OF NEW MACHINE END ====================================================


-- HYPER+L: Open news.google.com in the default browser
lfun = function()
  news = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open http://news.google.com')"
  hs.osascript.javascript(news)
  k.triggered = true
end
-- k:bind('', 'l', nil, lfun)
-- --------------- G R I D -------------------------------
hs.hotkey.bind(hyper, "S", function()
	hs.grid.toggleShow()
end)

-- Set grid size.
hs.grid.GRIDWIDTH  = 4
hs.grid.GRIDHEIGHT = 4
hs.grid.MARGINX    = 0
hs.grid.MARGINY    = 0
hs.hotkey.bind(hyper, ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
-- kolor i rozmiar fontów
hs.grid.ui.textSize = 80
hs.grid.ui.textColor = {1,0,0}
-- schowaj podpowiedź
hs.grid.ui.showExtraKeys = true
--
-- --------------- G R I D -------------------------------
--hs.hotkey.bind(hyper, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)
hs.hotkey.bind(hyper, '=', function() hs.grid.adjustWidth(1)   end)
hs.hotkey.bind(hyper, '-', function() hs.grid.adjustWidth(-1)  end)
hs.hotkey.bind(hyper, 'F', function() hs.window.focusedWindow():toggleFullScreen() end)
hs.hotkey.bind(hyper, 'J', hs.grid.pushWindowDown)
hs.hotkey.bind(hyper, 'K', hs.grid.pushWindowUp)
hs.hotkey.bind(hyper, 'H', hs.grid.pushWindowLeft)
hs.hotkey.bind(hyper, 'L', hs.grid.pushWindowRight)
hs.hotkey.bind(hyper, 'U', hs.grid.resizeWindowTaller)
hs.hotkey.bind(hyper, 'O', hs.grid.resizeWindowWider)
hs.hotkey.bind(hyper, 'I', hs.grid.resizeWindowThinner)
hs.hotkey.bind(hyper, 'Y', hs.grid.resizeWindowShorter)
hs.hotkey.bind(mash, 'left',  function() hs.window.focusedWindow():focusWindowWest()  end)
hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():focusWindowEast()  end)
hs.hotkey.bind(mash, 'up',    function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(mash, 'down',  function() hs.window.focusedWindow():focusWindowSouth() end)


-- set up your instance(s)
expose = hs.expose.new(nil,{showThumbnails=true})		-- default windowfilter, no thumbnails
expose_app = hs.expose.new(nil,{onlyActiveApplication=true})	-- show windows for the current application
expose_space = hs.expose.new(nil,{includeOtherSpaces=false})	-- only windows in the current Mission Control Space
expose_browsers = hs.expose.new{'Firefox','Safari','Google Chrome'}	-- specialized expose using a custom windowfilter
-- for your dozens of browser windows :)

-- then bind to a hotkey
hs.hotkey.bind(hyper,'e','Expose',function()expose:toggleShow()end)
hs.hotkey.bind(hyper,'q','App Expose',function()expose_app:toggleShow()end)
hs.hotkey.bind(hyper,'b','App Expose',function()expose_browsers:toggleShow()end)
hs.hotkey.bind(hyper,'a','App Expose',function()expose_space:toggleShow()end)

-- Applications hotkeys
hs.hotkey.bind(hyper,'=',function()spoon.HSKeybindings:show()end)
hs.hotkey.bind(hyper,'-',function()spoon.AClock:toggleShow()end)
hs.hotkey.bind(hyper,'8',function()popclickPlayPause()end)
hs.hotkey.bind(hyper,'9',function()MikrotikDialogBox(Mikrotik)end)
hs.hotkey.bind(hyper,'0',function()VPNDialogBox(ConnectVPN)end)
hs.hotkey.bind(hyper, "Z", function()hs.application.launchOrFocus("Finder")end)


-- Screen Lock
function lockScreen()
    os.execute("/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -suspend")
end
hs.hotkey.bind(hyper, "F12", function()lockScreen()end)

-- --------- SPOONS --------------------
ksheet = hs.loadSpoon("KSheet")
hs.hotkey.bind(hyper, "F11", function()ksheet:toggle()end)
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
hs.loadSpoon("AClock")
hs.loadSpoon("HSKeybindings")
--hs.loadSpoon("PopupTranslateSelection")
hs.loadSpoon("DeepLTranslate")


-- SWITCHER
switcher_browsers = hs.window.switcher.new{'Firefox','Safari','Google Chrome'} -- specialized switcher for your dozens of browser windows :)
switcher_browsers.ui.textSize = 6                   -- in screen points
switcher_browsers.ui.showTitles = true             -- show window titles
switcher_browsers.ui.selectedThumbnailSize = 500
switcher_browsers.ui.showSelectedThumbnail = true    -- show a larger thumbnail for the currently selected window
switcher_browsers.ui.showSelectedTitle = true        -- show larger title for the currently selected window

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt','tab','Next window',function()switcher_browsers:next()end)
hs.hotkey.bind('alt-shift','tab','Prev window',function()switcher_browsers:previous()end)
