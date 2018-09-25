-- Battery

b100 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
..a...b..
.........
.........
.........
.........
.........
.........
.........
..d...c..
4.......2
3.......3
]]
b90 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
..a...b..
.........
.........
.........
.........
.........
.........
..d...c..
4.......2
3.......3
]]
b80 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
.........
..a...b..
.........
.........
.........
.........
.........
..d...c..
4.......2
3.......3
]]
b70 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
.........
.........
..a...b..
.........
.........
.........
.........
..d...c..
4.......2
3.......3
]]
b60 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
.........
.........
.........
..a...b..
.........
.........
.........
..d...c..
4.......2
3.......3
]]
b50 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
.........
.........
.........
.........
..a...b..
.........
.........
..d...c..
4.......2
3.......3
]]
b40 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
.........
.........
.........
.........
.........
..a...b..
.........
..d...c..
4.......2
3.......3
]]
b30 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
.........
.........
.........
.........
.........
.........
..a...b..
..d...c..
4.......2
3.......3
]]
b20 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
.........
.........
.........
.........
.........
.........
.........
..d...c..
4.......2
3.......3
]]
b0 = [[ASCII:
..g...h..
..j...i..
45.....52
.........
.........
.........
.........
.........
.........
.........
.........
.........
.........
4.......2
3.......3
]]
black  = { red = 0, blue = 0, green = 0, alpha = 1 }
clear  = { red = 0, blue = 0, green = 0, alpha = 0 }
white  = { red = 1, blue = 1, green = 1, alpha = 1 }
gray   = { red = .2, blue = .2, green = .2, alpha = 1 }

kontekst = {
    {
        strokeColor = black,
        fillColor = white,
        antialias = false,
        shouldClose = true
    }
}
bname, percent, time2live, source, amp, cap, health, condition, charging, finish, time2full, voltage, cycles = ""


function refreshBattery()
     bname = hs.battery.name()
     percent = hs.battery.percentage()
     time2live = hs.battery.timeRemaining()
    if time2live < 0 then
        time2live = 'Never'
    else
     time2liveh = math.floor(time2live / 60)
     time2livem = math.floor(time2live % 60)
     time2live = time2liveh..':'..time2livem
    end
     source = hs.battery.powerSource()
     amp = hs.battery.amperage()
     cap = hs.battery.capacity()
     health = hs.battery.health()
     condition = hs.battery.healthCondition()
    if hs.battery.isCharging() then charging = 'Charging...' else charging = 'Not Charging' end
    if hs.battery.isFinishingCharge() then finish = 'Yes' else finish = 'No' end
     time2full = hs.battery.timeToFullCharge()
     voltage = hs.battery.voltage()
     cycles = hs.battery.cycles()

    val = math.floor(hs.battery.percentage())
    if val <= 100 and val >= 90 then batImage = hs.image.imageFromASCII(b100, kontekst)
    elseif val <= 90 and val >= 80 then batImage = hs.image.imageFromASCII(b90, kontekst)
    elseif  val < 80 and val >= 70  then batImage = hs.image.imageFromASCII(b80, kontekst)
    elseif  val < 70 and val >= 60  then batImage = hs.image.imageFromASCII(b70, kontekst)
    elseif  val < 60 and val >= 50  then batImage = hs.image.imageFromASCII(b60, kontekst)
    elseif  val < 50 and val >= 40  then batImage = hs.image.imageFromASCII(b50, kontekst)
    elseif  val < 40 and val >= 30  then batImage = hs.image.imageFromASCII(b40, kontekst)
    elseif  val < 30 and val >= 20  then batImage = hs.image.imageFromASCII(b30, kontekst)
    elseif  val < 20 and val >= 10  then batImage = hs.image.imageFromASCII(b20, kontekst)
    elseif  val < 10 then batImage = hs.image.imageFromASCII(b0, kontekst)
    end
    battery:setIcon(batImage)
    battery:setMenu(battMenu())
end
function battMenu()
    local menu = { 
        { title = 'Load  : '..percent..' %'}, 
        { title = 'Empty : '..time2live}, 
        { title = 'Source: '..source}, 
--        { title = 'Amperage:   '..amp..' mAh'}, 
--        { title = 'Capacity:    '..cap..' mAh'},
--        { title = 'Health:    '..health},
--        { title = 'Condition:    '..condition},
        { title = ''..charging},
--        { title = 'Finish charge:    '..finish},
--        { title = 'Time to full:    '..time2full..' min'},
--        { title = 'Voltage:    '..voltage..' mV'},
--        { title = 'Cycles:    '..cycles}
        { title = 'Disk: '..diskSize}
    
    }
    return menu
end
function refreshDysk()
    diskTable = hs.fs.volume.allVolumes()
--    diskSize = diskTable["NSURLVolumeTotalCapacityKey"]
    diskSize = '123456'
end

dysk = hs.fs.volume.new(refreshDysk)
battery = hs.menubar.newWithPriority(2)
battery:setTooltip("ile soku w baterii")
refreshDysk()
refreshBattery()

if battery then
--    battimer = hs.timer.new(5, refreshBattery , true)
--    battimer:start()
    batwatch = hs.battery.watcher.new(refreshBattery)
    batwatch:start()
    hs.alert.show("Battery loaded")
end
