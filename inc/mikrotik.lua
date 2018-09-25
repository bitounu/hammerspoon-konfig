-- Mikrotik commands for firewall /paczor/
function MikrotikDialogBox(ActionFunc)
    test = hs.chooser.new(ActionFunc)
    test:rows(6)
    test:choices({{["text"] = "Internet Off", ["subText"] = "", ["id"] = "0ff_Internet"},
                {["text"] = "TV Off", ["subText"] = "", ["id"] = "0ff_TV"},
                {["text"] = "pc miki On", ["subText"] = "", ["id"] = "0n_PC_Miki"},
                {["text"] = "pc antek On", ["subText"] = "", ["id"] = "0n_PC_Antek"},
                {["text"] = "pc obu On", ["subText"] = "", ["id"] = "0n_PCs"},
                {["text"] = "iPhone miki On", ["subText"] = "", ["id"] = "0n_iPhone_Miki"},
                {["text"] = "iPhone antek On", ["subText"] = "", ["id"] = "0n_iPhone_Antek"},
                {["text"] = "telefony obu On", ["subText"] = "", ["id"] = "0n_Phones"},
                {["text"] = "mac miki On", ["subText"] = "", ["id"] = "0n_Macbook17"},
                {["text"] = "iPady On", ["subText"] = "", ["id"] = "0n_iPady"},
            
            })
    test:show()
end
function Mikrotik(input)
--        hs.alert("Uruchamiam na routerze skrypt:  "..input.id)
        komenda = "/Users/paczor/bin/mikrotik-firerule.sh" .. " " .. input.id
--        hs.alert.show(komenda)
        out = os.execute(komenda)
end
hs.alert.show("Mikrotik loaded")

