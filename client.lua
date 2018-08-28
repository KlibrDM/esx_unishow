ESX                             = nil
local isInUse                   = 0
local showUser                  = ''
local isThrowingMoney           = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function OpenPositionMenu(zone)
	local elements = {}
	for k,v in pairs(Config.Salle) do
	   table.insert(elements,{
       label = v.label,
       pos  = v.pos
     })
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'strip',
		{
			title  = 'Position Menu',
			elements = elements
		},
		function(data, menu)
      OpenDancerMenu(data.current,zone)
		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'strip_menu'
			CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ for a private dance'
			CurrentActionData = {zone = zone}
		end
	)
end

function OpenDancerMenu(position,zone)
  local position = position
	local elements = {}
  if isInUse == 1 then
        table.insert(elements,{
        label = 'Stop show',
        hash  = '',
        type = ''
      })
  else
    for i=1,#Config.Ped do
      table.insert(elements,{
        label = Config.Ped[i].label .. " - $" .. Config.Price,
        hash  = Config.Ped[i].hash,
        type = Config.Ped[i].type
      })
    end
  end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'strip',
		{
			title  = 'Dancer Menu',
			elements = elements
		},
		function(data, menu)
      	if data.current.label == 'Stop show'	then
          isInUse = 0
      		TriggerServerEvent('esx_unishow:DeleteShow',position.label)
          ESX.UI.Menu.CloseAll()
      	else
      		OpenDanceMenu(data.current,position,zone)
      	end
		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'strip_menu'
			CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ for a private dance'
			CurrentActionData = {zone = zone}
		end
	)
end

function OpenDanceMenu(dancer,position,zone)
  local position = position
  local dancer = dancer
  local elements = {}
  for k,v in pairs(Config.Dict) do
    table.insert(elements,{
      label = v.label,
      name  = v.name,
      anim = v.anim,
    })
  end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'strip',
		{
			title  = 'Dance Menu',
			elements = elements
		},
		function(data, menu)
      ESX.TriggerServerCallback('esx_unishow:isShowPaid', function(isShowPaid)
        if isShowPaid == 1 then
        showUni(data.current,dancer,position)
        end
      end)
		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'strip_menu'
			CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ for a private dance'
			CurrentActionData = {zone = zone}
		end
	)
end

function showUni(dance,dancer,position)
  ESX.UI.Menu.CloseAll()
  isInUse = 1
  showUser = GetPlayerName(source)
  TriggerEvent('chatMessage', "^9Vanilla Unicorn", {255, 255, 255}, "Have fun! Stop the show with ^3U^0.")
  TriggerServerEvent('esx_unishow:DeleteShow',position.label)
  
  Wait(1000)
  RequestModel(GetHashKey(dancer.hash))
  while not HasModelLoaded(GetHashKey(dancer.hash)) do
    Wait(1)
  end
  
  RequestAnimDict(dance.name)
  while not HasAnimDictLoaded(dance.name) do
    Wait(1)
  end
  
  if dance.name == "mini@strip_club@private_dance@part3" then
    position.pos.x = 118.98
    position.pos.y = -1301.72
    position.pos.z = 28.57
    position.pos.a = 123.50
  end
  
  stripper =  CreatePed(dancer.type, dancer.hash, position.pos.x, position.pos.y, position.pos.z, position.pos.a, true, true)
  SetPedArmour(stripper, 0)
  SetPedMaxHealth(stripper, 200)
  SetPedDiesWhenInjured(ped, false)
  local param = {label=position.label,ped=stripper}
  TriggerServerEvent('esx_unishow:RegisterShow',param)
  
  TaskPlayAnim(stripper,dance.name,dance.anim, 8.0, 0.0, -1, 1, 0, 0, 1, 0)
  
  RequestAnimDict(Config.Sit.name)
  while not HasAnimDictLoaded(Config.Sit.name) do
    Citizen.Wait(0)
  end
  SetEntityHeading(GetPlayerPed(-1), 34.52)
  TaskPlayAnim(GetPlayerPed(-1),Config.Sit.name,Config.Sit.anim, 8.0, -8.0, -1, 1, 0, 0, 0, 0)

  Wait(Config.ShowTime*1000)
  if(isInUse == 1) then
    TriggerServerEvent('esx_unishow:DeleteShow',Config.Salle.mainscene.label)
    TriggerEvent('esx:showNotification', "Show ended! You can go for another round.")
  end
  
end

function MoneyThrow()
  ESX.TriggerServerCallback('esx_unishow:isMoneyThrowed', function(isMoneyThrowed)
    if isMoneyThrowed == 1 then
        local randomanim = math.random(1,3)
        if randomanim == 1 then
          dict = Config.MoneyThrowAnim.anim1.name
          anim = Config.MoneyThrowAnim.anim1.anim
        elseif randomanim == 2 then
          dict = Config.MoneyThrowAnim.anim2.name
          anim = Config.MoneyThrowAnim.anim2.anim
        else
          dict = Config.MoneyThrowAnim.anim3.name
          anim = Config.MoneyThrowAnim.anim3.anim
        end
        if isThrowingMoney == 0 then
          RequestAnimDict(dict)
          while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
          end
          TaskPlayAnim(GetPlayerPed(-1),dict,anim, 8.0, -8.0, -1, 1, 0, 0, 0, 0)
          isThrowingMoney = 1
        end
        HasAlreadyEnteredMarker = false
			  TriggerEvent('esx_unishow:hasExitedMarker', LastZone)
    end
  end)
end


RegisterNetEvent('esx_unishow:StopDance')
AddEventHandler('esx_unishow:StopDance',function(ped)
  ClearPedTasks(GetPlayerPed(-1))
  isInUse = 0
  ClearPedTasksImmediately(ped)
  DeletePed(ped)
end)

AddEventHandler('esx_unishow:hasEnteredMarker', function(zone)
  if zone == 'menustrip' then
    CurrentAction     = 'strip_menu'
    CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ for a private dance'
    CurrentActionData = {zone = zone}
  else
    CurrentAction     = 'money_throw'
    CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to throw $'..Config.MoneyThrowAmount
    CurrentActionData = {zone = zone}
  end
end)

AddEventHandler('esx_unishow:hasExitedMarker', function(zone)
  if zone == 'menustrip' then
    CurrentAction = nil
    ESX.UI.Menu.CloseAll()
  else
    CurrentAction = nil
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
      
    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1) then
        if v.Label == 'PrivateDance' then
          isInMarker  = true
          currentZone = 'menustrip'
          LastZone    = 'menustrip'
        else
          isInMarker  = true
          currentZone = 'money_throw'
          LastZone    = 'money_throw'
        end
      end
    end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_unishow:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_unishow:hasExitedMarker', LastZone)
		end
	end
end)

-- Private Dance Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      if IsControlJustReleased(0, 38) then
        if CurrentAction == 'strip_menu' then
          OpenPositionMenu(CurrentActionData.zone)
        elseif CurrentAction == 'money_throw' then
          MoneyThrow()
        end
        CurrentAction = nil
      end
    end
    
    if IsControlJustReleased(0, 303) and GetPlayerName(source) == showUser then
      TriggerServerEvent('esx_unishow:DeleteShow',Config.Salle.mainscene.label)
    end
      
    if IsControlJustReleased(0, 303) and isThrowingMoney == 1 then
      ClearPedTasks(GetPlayerPed(-1))
      isThrowingMoney = 0
    end
  end
end)


-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Config.Zones) do
      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, false, false, false, false)
      end
    end
  end
end)