local ESX = nil
local working = false 
local lockpickvan = false 
local inmision = false
local havevan = false 
local robbed = false 
local vanb = {}
local dyblip = {}
local van

-- Cores
CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(script) ESX = script end)
        Wait(124)
    end

    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
	AddRelationshipGroup('Guards')
end)


CreateThread(function()
    while true do
        sleep = 500
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        local vanpos = GetEntityCoords(van) 
        local dist1 = GetDistanceBetweenCoords(pcoords, vector3(-90.77, -67.6, 57.93), true)
        if dist1 <= 7.0 then
            sleep = 0
            Marker(-90.77, -67.6, 57.93)
            if dist1 <= 1.5 then
                HelpText(Config.Locale['tpe_room'])

                if IsControlJustPressed(0, 38) then
                    Teleport(ped, vector3(-112.83, -65.93, 42.93))
                end
            end
        end 

        local dist2 = GetDistanceBetweenCoords(pcoords, vector3(-112.83, -65.93, 42.93), true)
        if dist2 <= 1.5 then
            sleep = 0
            Marker(-112.83, -65.93, 42.93)
            if dist2 <= 1.5 then
                HelpText(Config.Locale['tpex_room'])

                if IsControlJustPressed(0, 38) then
                    Teleport(ped, vector3(-90.77, -67.6, 57.93))
                end
            end
        end 

        local dist3 = GetDistanceBetweenCoords(pcoords, vector3(-112.56, -67.98, 42.89), true)
        if dist3 <= 3.0 then
            sleep = 0
            Marker(-112.56, -67.98, 42.89)
            if dist3 <= 1.5 then
                if working == false then
                    HelpText(Config.Locale['get_info'])
                
                    if IsControlJustPressed(0, 38) then
                        if inmision == false then
                            if robbed == true then
                                Notify(Config.Locale['robbed'])
                            else
                                TriggerServerEvent('ivak-vanthief:AkR53PsKWETU98pDUMah')
                            end
                        else
                            Notify(Config.Locale['try'])
                        end
                    end
                end
            end
        end 

        local dist4 = GetDistanceBetweenCoords(pcoords, Config.Delivery, true)
        if dist4 <= 7.0 then
            if IsPedInAnyVehicle(ped) and havevan == true then
                local vehicleModel = GetEntityModel(GetVehiclePedIsIn(ped))
                if vehicleModel == GetHashKey(Config.Van) then
                    sleep = 0
                    Marker(-116.36, -59.71, 55.42,true)
                    if dist4 <= 1.5 then
                        if working == false then
                            HelpText(Config.Locale['dy_van'])
                        
                            if IsControlJustPressed(0, 38) then
                                local vehicle = GetVehiclePedIsIn(ped)
                                TaskLeaveVehicle(ped, vehicle, 1)
                                Wait(3000)
                                TriggerServerEvent('ivak-vanthief:KUsRmWpBKDuFb7NnmbCQ')
                                ESX.Game.DeleteVehicle(vehicle)
                                havevan = false
                                RemoveBlip(dyblip[1])
                                table.remove(dyblip)
                            end
                        end
                    end
                end
            end
        end 
			
        local vandist = GetDistanceBetweenCoords(pcoords, vanpos.x, vanpos.y, vanpos.z, true)
        if vandist <= 3 and lockpickvan == true then
            sleep = 0
            if working == false then
                HelpText(Config.Locale['lockpick_van'])

                if IsControlJustPressed(1, 47) then
                    FreezeEntityPosition(ped, true)
                    TriggerServerEvent('ivak-vanthief:YcB9jfzrY9TbrvWIhUVu', pcoords)
                    working = true
                    ExecuteCommand('e mechanic4') 
                    Wait(30000)
                    ExecuteCommand('e c')
                    SetVehicleDoorsLocked(van, 1)
                    RemoveBlip(vanb[1])
                    table.remove(vanb)
                    FreezeEntityPosition(ped, false)
                    lockpickvan = false
                    working = false
                    deliveryblip = AddBlipForCoord(vector3(-116.36, -59.71, 55.42))
                    SetBlipColour(deliveryblip, 1)
                    SetBlipRoute(deliveryblip, true)
                    SetBlipRouteColour(deliveryblip, 1)
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentString(Config.Locale['dy_blip'])
                    EndTextCommandSetBlipName(deliveryblip)
                    table.insert(dyblip, deliveryblip)
                    TriggerServerEvent('ivak-vanthief:8mwlGHX0z3CU6oeLNRKx')
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        sleep = 500
        if robbed == true then
            sleep = 0
            Wait(Config.TimeForNewRob)
            robbed = false
        end
        Wait(sleep)
    end
end)

-- Events
RegisterNetEvent('ivak-vanthief:9mb1Bh0fjClitijWbUOq')
AddEventHandler('ivak-vanthief:9mb1Bh0fjClitijWbUOq', function()
    working = true
    TriggerServerEvent('ivak-vanthief:kppKY43jcIHnjPlCRw4D')
    ExecuteCommand('e type')
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start", 3, 30, hack)
end)

RegisterNetEvent('ivak-vanthief:tUznYAPengeJvqdHNxsJ')
AddEventHandler('ivak-vanthief:tUznYAPengeJvqdHNxsJ', function()
    inmision = true
end)

RegisterNetEvent('ivak-vanthief:rnKxIFXMYTeaf9YuAevL')
AddEventHandler('ivak-vanthief:rnKxIFXMYTeaf9YuAevL', function()
    inmision = false
end)

RegisterNetEvent('ivak-vanthief:gtoP7JGjzoYFN8DPWXln')
AddEventHandler('ivak-vanthief:gtoP7JGjzoYFN8DPWXln', function()
    robbed = true
end)

RegisterNetEvent('ivak-vanthief:notify')
AddEventHandler('ivak-vanthief:notify', function(msg)
    Notify(msg)
end)

RegisterNetEvent('ivak-vanthief:KwPlSZkI2vrqqPDi1Pd4')
AddEventHandler('ivak-vanthief:KwPlSZkI2vrqqPDi1Pd4', function(coords)
    local alpha = 250
    local policeblip = AddBlipForRadius(coords.x, coords.y, coords.z, 50.0)

    SetBlipHighDetail(policeblip, true)
    SetBlipColour(policeblip, 1)
    SetBlipAlpha(policeblip, alpha)
    SetBlipAsShortRange(policeblip, true)

    while alpha ~= 0 do
        Citizen.Wait(150)
        alpha = alpha - 1
        SetBlipAlpha(policeblip, alpha)

        if alpha == 0 then
            RemoveBlip(policeblip)
            return
        end
    end
end)

-- Functions
function SpawnVan()
    local random = math.random(1, #Config.Locations)
    local vancoords = Config.Locations[random]
    RequestModel(GetHashKey(Config.Van))
    while not HasModelLoaded(GetHashKey(Config.Van)) do
        Citizen.Wait(10)
    end
    van = CreateVehicle(GetHashKey(Config.Van), vector3(vancoords.pos.x, vancoords.pos.y, vancoords.pos.z), vancoords.heading, true, false)
    SetVehicleDoorsLocked(van, 2)
    for i = 1, #vancoords.guards do
        RequestModel(GetHashKey(vancoords.guards[i].model))
        while not HasModelLoaded(GetHashKey(vancoords.guards[i].model)) do
            Citizen.Wait(10)
        end
		npc = CreatePed(4,GetHashKey(vancoords.guards[i].model), vancoords.guards[i].coords[1], vancoords.guards[i].coords[2], vancoords.guards[i].coords[3], vancoords.guards[i].coords[4], true, true)
		SetPedCanSwitchWeapon(npc, true)
		SetPedAccuracy(npc, math.random(10,30))
		SetEntityInvincible(npc, false)
		SetEntityVisible(npc, true)
		GiveWeaponToPed(npc, GetHashKey(Config.GuardsWeapon), 250, false, false)
		SetPedDropsWeaponsWhenDead(npc, false)
		SetPedFleeAttributes(npc, 0, false)
		SetPedRelationshipGroupHash(npc, GetHashKey("Guards"))
		SetPedAlertness(npc,3)
		SetRelationshipBetweenGroups(0, GetHashKey("Guards"), GetHashKey("Guards"))
		SetRelationshipBetweenGroups(5, GetHashKey("Guards"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("Guards"))
		SetModelAsNoLongerNeeded(GetHashKey(GetHashKey(vancoords.guards[i].model)))
	end
    lockpickvan = true
    havevan = true
    vanblip = AddBlipForCoord(vector3(vancoords.pos.x, vancoords.pos.y, vancoords.pos.z))
    SetBlipColour(vanblip, 1)
    SetBlipRoute(vanblip, true)
    SetBlipRouteColour(vanblip, 1)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Config.Locale['van_blip'])
    EndTextCommandSetBlipName(vanblip)
    table.insert(vanb, vanblip)
end

function hack(success, timeremaining)
	Wait(1)
	if success then
        working = false
		TriggerEvent('mhacking:hide')
        ExecuteCommand('e c')
        Notify(Config.Locale['suc_hack'])
        SpawnVan()
	else
        working = false
		TriggerEvent('mhacking:hide')
        ExecuteCommand('e c')
        Notify(Config.Locale['fail_hack'])
	end
end

function HelpText(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function Notify(text)
	ESX.ShowNotification(text)
end

function Teleport(ped, coords)
    DoScreenFadeOut(100)
    Wait(750)
    ESX.Game.Teleport(PlayerPedId(), coords)
    DoScreenFadeIn(100)
end

function Marker(x, y, z, big)
    if big == true then
	    DrawMarker(27, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 3.5, 66, 30, 120, 90, false, true, 2, true, false, false, false)
    else
        DrawMarker(27, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.2, 1.2, 1.2, 66, 30, 120, 90, false, true, 2, true, false, false, false)
    end
end
