local GetPlayerIdentifierByType = GetPlayerIdentifierByType

local sv_maxclients = GetConvarInt('sv_maxclients', 0)
AddConvarChangeListener('sv_maxclients', function()
    sv_maxclients = GetConvarInt('sv_maxclients', 0)
end)


---@type { username: string, steam: string }[]
local Disconnected = {}

lib.callback.register('prp-scoreboard:getPlayers', function()
    local activePlayer = GetPlayers()

    local data = {
        maxPlayers = sv_maxclients,
        online = {},
        offline = Disconnected
    }

    for _, ply in ipairs(activePlayer) do
        local identifier = GetPlayerIdentifierByType(ply, 'steam') or GetPlayerIdentifierByType(ply, 'fivem')

        table.insert(data.online, {
            id = ply,
            username = GetPlayerName(ply),
            steam = identifier
        })
    end

    return data
end)

--- Leaving handler
AddEventHandler('playerDropped', function()
    local username = GetPlayerName(source)
    local identifier = GetPlayerIdentifierByType(source, 'steam') or GetPlayerIdentifierByType(source, 'fivem')

    table.insert(Disconnected, {
        username = username,
        steam = identifier
    })
end)

--- Connecting handler
--- remove player from Disconnected table when he's rejoining back...
AddEventHandler('playerConnecting', function()
    local identifier = GetPlayerIdentifierByType(source, 'steam') or GetPlayerIdentifierByType(source, 'fivem')

    -- Check if identifier is in table
    for index, iden in ipairs(Disconnected) do
        if iden.steam == identifier then
            table.remove(Disconnected, index)
            return
        end
    end
end)