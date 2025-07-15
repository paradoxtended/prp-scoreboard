-------------------------------------------------------------------------------------------------------------------------------------------------------
--- SCRIPT, do not touch unless you know what ur doing
-------------------------------------------------------------------------------------------------------------------------------------------------------
local playerGamerTags = {}
local distanceToCheck = Config.MaxDistanceForIds or 50

--- Removes all cached tags
local function cleanAllGamerTags()
    for _, v in pairs(playerGamerTags) do
        if IsMpGamerTagActive(v.gamerTag) then
            RemoveMpGamerTag(v.gamerTag)
        end
    end
    playerGamerTags = {}
end

--- Loops through every player, checks distance and draws or hides the tag
local function showPlayerIds()
    local curCoords = GetEntityCoords(PlayerPedId())
    -- Per infinity this will only return players within 300m
    local allActivePlayers = GetActivePlayers()

    for _, pid in ipairs(allActivePlayers) do
        -- Resolving player
        local targetPed = GetPlayerPed(pid)

        -- If we have not yet indexed this player or their tag has somehow dissapeared (pause, etc)
        if
            not playerGamerTags[pid]
            or playerGamerTags[pid].ped ~= targetPed --ped can change if it leaves the networked area and back
            or not IsMpGamerTagActive(playerGamerTags[pid].gamerTag)
        then
            local playerStr = GetPlayerServerId(pid)
            playerGamerTags[pid] = {
                gamerTag = CreateFakeMpGamerTag(targetPed, playerStr, false, false, 0),
                ped = targetPed
            }
        end
        local targetTag = playerGamerTags[pid].gamerTag

        -- Distance Check
        local targetPedCoords = GetEntityCoords(targetPed)
        if #(targetPedCoords - curCoords) <= distanceToCheck then
            SetMpGamerTagVisibility(targetTag, 0, 1)
        else
            SetMpGamerTagVisibility(targetTag, 0, 0)
        end
    end
end

local function openPlayerList()
    local data = lib.callback.await('prp-scoreboard:getPlayers', false)

    showPlayerIds()

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'showList',
        data = data
    })
end

RegisterNuiCallback('hideList', function(_, cb)
    cb(1)
    SetNuiFocus(false, false)
    cleanAllGamerTags()
end)

RegisterCommand(Config.Command, function()
    openPlayerList()
end, false)

RegisterKeyMapping(Config.Command, 'Open player list', 'keyboard', Config.EnableKey)