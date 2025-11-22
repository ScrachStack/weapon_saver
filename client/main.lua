CreateThread(function()
    Wait(1500)
    TriggerServerEvent("weapons:requestLoad")
end)

RegisterNetEvent("weapons:giveBack")
AddEventHandler("weapons:giveBack", function(weapons)
    local ped = PlayerPedId()

    for _, w in ipairs(weapons) do
        GiveWeaponToPed(ped, tonumber(w.hash), w.ammo or 250, false, true)
    end
end)

local function GetAllWeaponsDynamic()
    local ped = PlayerPedId()
    local weapons = {}

    for hash = 0, 0xFFFFFFFF do
        local group = GetWeapontypeGroup(hash)
        if group and group ~= 0 and HasPedGotWeapon(ped, hash, false) then
            table.insert(weapons, {
                hash = hash,
                ammo = GetAmmoInPedWeapon(ped, hash)
            })
        end
    end

    return weapons
end


AddEventHandler("onResourceStop", function(res)
    if res == GetCurrentResourceName() then
        TriggerServerEvent("weapons:save", GetAllWeaponsDynamic())
    end
end)
