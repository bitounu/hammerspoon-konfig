-- Ceffeine
caffeine = hs.menubar.new()
caffeine:setTooltip("@ - normalny\n!! - pobudzony")
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("!!")
    else
        caffeine:setTitle("@")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

hs.alert.show("Caffeine loaded")

