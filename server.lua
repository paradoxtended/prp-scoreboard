local GetPlayerIdentifierByType = GetPlayerIdentifierByType

local sv_maxclients = GetConvarInt('sv_maxclients', 0)
AddConvarChangeListener('sv_maxclients', function()
    sv_maxclients = GetConvarInt('sv_maxclients', 0)
end)

-- Add count data to each job after script start
for _, job in ipairs(Config.Jobs) do
    job.count = 0
end

---@type { username: string, steam: string }[]
local Disconnected = {}

lib.callback.register('prp-scoreboard:getPlayers', function()
    local activePlayers = GetPlayers()

    local data = {
        maxPlayers = sv_maxclients,
        online = {},
        offline = Disconnected,
        jobs = lib.table.deepclone(Config.Jobs)
    }

    for _, ply in ipairs(activePlayers) do
        local player = Framework.getPlayerFromId(ply)

        for index, job in ipairs(Config.Jobs) do
            local jobData = data.jobs[index]

            if player:hasOneOfJobs(job.jobs) then
                jobData.count += 1
            end
        end

        table.insert(data.online, {
            id = ply,
            username = GetPlayerName(ply),
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