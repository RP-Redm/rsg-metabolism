local RSGCore = exports['rsg-core']:GetCoreObject()
local isLoggedIn = false
local PlayerData = {}
local roundtemp = 0

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = RSGCore.Functions.GetPlayerData()
end)

RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    PlayerData = {}
end)

-- check ped clothes / money
Citizen.CreateThread(function()
    while true do
        Wait(1500)
        if isLoggedIn then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local temp = Citizen.InvokeNative(0xB98B78C3768AF6E0,coords.x,coords.y,coords.z)
            roundtemp = tempformat(temp)
            
            for k,v in pairs(Config.ClothesCats) do
                local IsWearingClothes = Citizen.InvokeNative(0xFB4891BD7578CDC1 ,PlayerPedId(), v)
                if IsWearingClothes then 
                    roundtemp = roundtemp + 1
                end
            end
        end
    end
end)

---damage, effects
Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if isLoggedIn then
            ped = PlayerPedId()
            health = GetEntityHealth(ped)
            coords = GetEntityCoords(ped)
            if tonumber(roundtemp) <= -8 then
                SetEntityHealth(ped,health  - 5)
            elseif tonumber(roundtemp) <= -6 then
                SetEntityHealth(ped,health  - 2)
            elseif tonumber(roundtemp) <= -4 then
                SetEntityHealth(ped,health  - 1)
            end
            if health > 0 and health < 50 and tonumber(roundtemp) > 0 then 
                SetEntityHealth(ped,health  - 1)
                PlayPain(ped, 9, 1, true, true)
                Citizen.InvokeNative(0x4102732DF6B4005F, "MP_Downed", 0, true) -- AnimpostfxPlay
            else
                if Citizen.InvokeNative(0x4A123E85D7C4CA0B, "MP_Downed") then -- AnimpostfxIsRunning
                    Citizen.InvokeNative(0xB4FD7446BAB2F394, "MP_Downed") -- AnimpostfxStop
                end
            end
        end
    end
end)

function tempformat(n)
    return string.format("%.1f", n / 10^8)
end
