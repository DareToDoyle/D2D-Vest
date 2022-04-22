--MADE BY DareToDoyle#3835--

ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bombvest', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('bombvest', 1)
	TriggerClientEvent('D2D-Vest:Use', source)
	
end)

ESX.RegisterUsableItem('bombdefuse', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('bombdefuse', 1)
	TriggerClientEvent('D2D-Vest:Defuse', source)
	
end)

RegisterServerEvent('D2D-Vest:PlayerExplosion')
AddEventHandler('D2D-Vest:PlayerExplosion', function(coords)

    TriggerClientEvent("D2D-Vest:DetonateIfNearby", -1, coords)

end)
--MADE BY DareToDoyle#3835--
