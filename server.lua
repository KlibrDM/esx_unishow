TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local places ={}

function joueurs(ped)

local players = GetPlayers()
	for k,v in pairs(players) do
		TriggerClientEvent('esx_unishow:StopDance',v,ped)
	end
end

RegisterServerEvent('esx_unishow:RegisterShow')
AddEventHandler('esx_unishow:RegisterShow',function(param)
	table.insert(places,{
		label = param.label,
		ped   = param.ped
		})
end)

RegisterServerEvent('esx_unishow:DeleteShow')
AddEventHandler('esx_unishow:DeleteShow',function(label)
	for i=1,#places do
		if places[i].label == label then
			ped = places[i].ped
			joueurs(ped)
			table.remove(places,i)		
		end
	end
end)
  
ESX.RegisterServerCallback('esx_unishow:isShowPaid', function(source, callback)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
  local isShowPaid = 0
  local amount = Config.Price
  local target = Config.UnicornSociety
    
  TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)
    if xPlayer.get('money') >= amount then
      xPlayer.removeMoney(amount)
      account.addMoney(amount)
      isShowPaid = 1
      TriggerClientEvent('esx:showNotification', xPlayer.source, "You paid $"..amount.." for the show")
      callback(isShowPaid)
    else
      isShowPaid = 0
      TriggerClientEvent('esx:showNotification', xPlayer.source, "Not enough money")
      callback(isShowPaid)
    end
  end)
end)

ESX.RegisterServerCallback('esx_unishow:isMoneyThrowed', function(source, callback)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
  local isMoneyThrowed = 0
  local amount = Config.MoneyThrowAmount
  local target = Config.UnicornSociety
    
  TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)
    if xPlayer.get('money') >= amount then
      xPlayer.removeMoney(amount)
      account.addMoney(amount)
      isMoneyThrowed = 1
      TriggerClientEvent('esx:showNotification', xPlayer.source, "You threw $"..amount)
      callback(isMoneyThrowed)
    else
      isMoneyThrowed = 0
      TriggerClientEvent('esx:showNotification', xPlayer.source, "Not enough money")
      callback(isMoneyThrowed)
    end
  end)
end)