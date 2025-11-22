local SAVE_FILE = Config.Json.File
local weaponCache = {}

CreateThread(function()
    if not LoadResourceFile(GetCurrentResourceName(), SAVE_FILE) then
        SaveResourceFile(GetCurrentResourceName(), SAVE_FILE, json.encode({}), -1)
    else
        local data = LoadResourceFile(GetCurrentResourceName(), SAVE_FILE)
        weaponCache = json.decode(data) or {}
    end
end)

local function saveWeapons()
    SaveResourceFile(GetCurrentResourceName(), SAVE_FILE, json.encode(weaponCache, { indent = true }), -1)
end


function GetPlayerIdentifierFromConfig(src)
    local ids = GetPlayerIdentifiers(src)
    local wanted = Config.Identifier

    for _, fullID in ipairs(ids) do
        if fullID:find(wanted .. ":") then
            return fullID
        end
    end

    return nil
end

RegisterServerEvent("weapons:save")
AddEventHandler("weapons:save", function(weapons)
    local src = source
    local identifier = GetPlayerIdentifierFromConfig(src)
    if not identifier then
        print("[Weapon Saver] ERROR: No identifier found for player " .. src)
        return
    end

    weaponCache[identifier] = weapons

    SaveResourceFile(GetCurrentResourceName(), Config.Json.File, json.encode(weaponCache, {indent=true}), -1)
end)


RegisterNetEvent("weapons:requestLoad")
AddEventHandler("weapons:requestLoad", function()
    local src = source
    local identifier = GetPlayerIdentifierFromConfig(src)
    if not identifier then return end

    local weapons = weaponCache[identifier] or {}
    TriggerClientEvent("weapons:giveBack", src, weapons)
end)
