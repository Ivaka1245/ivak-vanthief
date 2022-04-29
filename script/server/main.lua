ESX = nil

TriggerEvent("esx:getSharedObject", function(script) ESX = script end)

RegisterServerEvent('ivak-vanthief:AkR53PsKWETU98pDUMah')
AddEventHandler('ivak-vanthief:AkR53PsKWETU98pDUMah', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xPlayers = ESX.GetPlayers()

    local cops = 0
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end

    if cops >= Config.MinPolice then
        TriggerClientEvent('ivak-vanthief:9mb1Bh0fjClitijWbUOq', src)
    else
        TriggerClientEvent('ivak-vanthief:notify', src, Config.Locale['no_cops'])
    end
end)

RegisterServerEvent('ivak-vanthief:YcB9jfzrY9TbrvWIhUVu')
AddEventHandler('ivak-vanthief:YcB9jfzrY9TbrvWIhUVu', function(coords)
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('ivak-vanthief:notify', xPlayers[i], Config.Locale['pol_msg'])
            TriggerClientEvent('ivak-vanthief:KwPlSZkI2vrqqPDi1Pd4', xPlayers[i], coords)
        end
    end
end)

RegisterServerEvent('ivak-vanthief:kppKY43jcIHnjPlCRw4D')
AddEventHandler('ivak-vanthief:kppKY43jcIHnjPlCRw4D', function()
    TriggerClientEvent('ivak-vanthief:tUznYAPengeJvqdHNxsJ', -1)
end)

RegisterServerEvent('ivak-vanthief:8mwlGHX0z3CU6oeLNRKx')
AddEventHandler('ivak-vanthief:8mwlGHX0z3CU6oeLNRKx', function()
    TriggerClientEvent('ivak-vanthief:gtoP7JGjzoYFN8DPWXln', -1)
end)



local paid = {}
RegisterServerEvent('ivak-vanthief:KUsRmWpBKDuFb7NnmbCQ')
AddEventHandler('ivak-vanthief:KUsRmWpBKDuFb7NnmbCQ', function()
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local money = Config.Reward
    local difference = #(GetEntityCoords(GetPlayerPed(xPlayer.source)) -  Config.Delivery) -- Must be the same as Client-Side line 78
    if difference <= 20 then
        if not paid[src] then
           
            if Config.UseBlackMoney == true then 
                xPlayer.addAccountMoney('black_money', money)
                TriggerClientEvent('ivak-vanthief:notify', src, Config.Locale['maked_money']..money..Config.Locale['black_money'])
            else
                xPlayer.addMoney(money)
                TriggerClientEvent('ivak-vanthief:notify', src, Config.Locale['maked_money']..money..Config.Locale['cash'])
            end

            TriggerClientEvent('ivak-vanthief:rnKxIFXMYTeaf9YuAevL', -1)
            paid[src] = ESX.SetTimeout(Config.TimeForNewRob, function()
                paid[src] = nil
            end)

        else
            --Add some ban event or just drop it
        end
    else
        --Add some ban event or just drop it
    end
end)


