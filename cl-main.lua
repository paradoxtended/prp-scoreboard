-------------------------------------------------------------------------------------------------------------------------------------------------------
--- CONFIG
-------------------------------------------------------------------------------------------------------------------------------------------------------

local EnableKey = 'PAGEUP'
local Command = 'playerList'

-------------------------------------------------------------------------------------------------------------------------------------------------------
--- SCRIPT, do not touch unless you know what ur doing
-------------------------------------------------------------------------------------------------------------------------------------------------------

local function openPlayerList()
    local data = lib.callback.await('prp-scoreboard:getPlayers', false)

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'showList',
        data = data
    })
end

RegisterNuiCallback('hideList', function(_, cb)
    cb(1)
    SetNuiFocus(false, false)
end)

RegisterCommand(Command, function()
    openPlayerList()
end, false)

RegisterKeyMapping(Command, 'Open player list', 'keyboard', EnableKey)