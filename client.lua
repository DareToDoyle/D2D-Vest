ESX = nil

local beep = false
local detonate = false
local beepdone = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
        ESX = obj
        end)
    end
end)

RegisterNetEvent('D2D-Vest:Use')
AddEventHandler('D2D-Vest:Use', function()
    local player = PlayerPedId()
    
    ESX.Streaming.RequestAnimDict('clothingtie', function()
    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_negative_a', 8.0, 2.0, 1200, 48, 10, 0, 0, 0)
    
    Citizen.Wait(200)
    
    SendNUIMessage({sound = "bpvest", volume = 0.8})
    SetPedArmour(player, 100)
    SetPedComponentVariation(player, 9, 14, 0, 2) -- CHANGE 14/0 TO TO WHATEVER BULLETPROOF VEST 1 & BULLETPROOF VEST 2 YOU WANT
   
    beep = true
    
    Citizen.Wait(500)
    TriggerEvent('D2D-Vest:Detonate')
    ESX.ShowNotification('Bomb has been armed!')
    detonate = true

end)
end)

RegisterNetEvent('D2D-Vest:Defuse')
AddEventHandler('D2D-Vest:Defuse', function()
    local player = PlayerPedId()
    
    ESX.Streaming.RequestAnimDict('clothingtie', function()
    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_negative_a', 8.0, 2.0, 1200, 48, 10, 0, 0, 0)
    
    Citizen.Wait(200)
    
    SendNUIMessage({sound = "bpvest", volume = 0.8})
    SetPedArmour(player, 0)
    SetPedComponentVariation(player, 9, 0, 0, 2) 
   
    beep = false
    detonate = false
    ESX.ShowNotification('Bomb has been defused!')


end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if beep == true then
            SendNUIMessage({sound = "beep", volume = 0.7})
        Citizen.Wait(1000)
        elseif beep == false then
    
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if beepdone == true then
            SendNUIMessage({sound = "beepdone", volume = 0.7})
        beepdone = false
        elseif beepdone == false then
    
        end
    end
end)


Citizen.CreateThread(function()
while true do
 Citizen.Wait(50)
if detonate == true and IsControlPressed(1, 38) then


 beep = false
 beepdone = true
 
 Citizen.Wait(1900)

local PlayerPos = GetEntityCoords(PlayerPedId(), true)
 local player = PlayerPedId()
 
     AddExplosion(PlayerPos.x, PlayerPos.y, PlayerPos.z, 5, 50.0, true, false, true)
    
    SetEntityHealth(player,0)
    TriggerServerEvent('D2D-Vest:PlayerExplosion', PlayerPos)
    detonate = false
    SetPedComponentVariation(player, 9,0 , 0, 2) -- DO NOT CHANGE
    elseif detonate == false then
end

end
end)

RegisterNetEvent("D2D-Vest:DetonateIfNearby")
AddEventHandler("D2D-Vest:DetonateIfNearby", function(coords)
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)
	print(#(coords - playerCoords))
        if #(coords - playerCoords) <= 10.0 then -- Change 10.0 to a distance you want
            SetEntityHealth(ped, 0)
        end
end)