-- OpenVPN connections and binds
function VPNDialogBox(ActionFunc)
    test = hs.chooser.new(ActionFunc)
    test:rows(6)
    test:choices({{["text"] = "VPN1", ["subText"] = "", ["id"] = "VPN1"},
                {["text"] = "VPN2", ["subText"] = "", ["id"] = "VPN2"},
            
            })
    test:show()
end
function ConnectVPN(input)
        hs.alert("Connecting to..."..input.id)
        hs.osascript._osascript("tell application \"Viscosity\" to connect \"" ..input.id.. "\"", "AppleScript")
end
hs.alert.show("VPN loaded")

