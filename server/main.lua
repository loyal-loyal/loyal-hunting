lib.locale()

if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
else
    print('Your Framework Unsupported')
    return
end

function notify(source,message,type)
    if Config.Framework == 'qb-core' then 
        TriggerClientEvent('QBCore:Notify', source, message, type)
    else
        TriggerClientEvent('esx:showNotification', source, message, type)
    end
end

local antifarm = {}

RegisterNetEvent('loyal-hunting:harvestCarcass')
AddEventHandler('loyal-hunting:harvestCarcass',function (entityId, bone)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local entity = NetworkGetEntityFromNetworkId(entityId)
    local entityCoords = GetEntityCoords(entity)
    if #(playerCoords - entityCoords)< 5 then
        if Antifarm(source, entityCoords) then
            local weapon = GetPedCauseOfDeath(entity)
            local item = Config.carcass[GetEntityModel(entity)]
            local grade = 1
            if InTable(Config.goodWeapon, weapon) then
                grade = 2
                if InTable(Config.headshotBones[GetEntityModel(entity)],bone) then
                    grade = 3
                end
            end
            if Config.Inventory == 'ox_inventory' then
                if exports.ox_inventory:CanCarryItem(source, item..grade , 1) then
                    DeleteEntity(entity)
                    exports.ox_inventory:AddItem(source, item..grade , 1)
                else
                    notify( source, locale('inventory_full'), "error")
                end
            else
                local src = source
                local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.AddItem(item..grade, 1)
			    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item..grade], "add",1)
                DeleteEntity(entity)
            end            

        else
            notify(source, locale('stop_farm'), "error")
        end
    else
        notify(source, locale('too_far'), "error")
    end
end)

function InTable(table, value)
    for i = 1, #table, 1 do
        if table[i] == value then
            return true
        end
    end
    return false
end

--------------------- SELL -----------------------------------
if Config.Framework == 'qb-core' then
    RegisterNetEvent('loyal-hunting:SellCarcass')
    AddEventHandler('loyal-hunting:SellCarcass',function (item)
        local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
        for i= 1,3 do
            local itemData = Player.Functions.GetItemByName(item..i)
            if itemData then
            if itemData.amount >= 1 then
                if i >1 then
                    local reward = Config.sellPrice[item].max * i * 5
                else
                    local reward = Config.sellPrice[item].max * i
                end
                if  Player.Functions.RemoveItem(item..i, 1) then
    			    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item..i], "remove",1)
    			    Player.Functions.AddMoney("cash",reward, "hunting")
                end
                break
            end
            end
        end
    end)
else
    RegisterNetEvent('loyal-hunting:SellCarcass')
    AddEventHandler('loyal-hunting:SellCarcass',function (item)
        local src = source
	    local Player = ESX.GetPlayerFromId(src)
        for i= 1,3 do
            if exports.ox_inventory:GetItemCount(src, item..i) >= 1 then
                if i >1 then
                    local reward = Config.sellPrice[item].max * i * 5
                else
                    local reward = Config.sellPrice[item].max * i
                end
                exports.ox_inventory:RemoveItem(src, item..i, 1)

                if  exports.ox_inventory:RemoveItem(src, item..i, 1) then
	    		    Player.addMoney(reward, "hunting")
                end
                break
            end
        end
    end)
end

--------------------Antifarm------------------------------------------
function Antifarm(source,coords)
    if Config.antiFarm.enable == false then return true end
    if Config.antiFarm.personal == false then
        source = 1
    end

    local curentTime = os.time()
    if not next(antifarm) or antifarm[source] == nil or not next(antifarm[source]) then -- table empty
        antifarm[source] = {}
        table.insert(antifarm[source],{time = curentTime, coords = coords, amount= 1})
        return true
    end
    for i = 1, #antifarm[source], 1 do
        if (curentTime - antifarm[source][i].time) > Config.antiFarm.time then -- delete old table
            table.remove(antifarm[source], i)
        elseif #(antifarm[source][i].coords - coords) < Config.antiFarm.size then -- if found table in coord
            if antifarm[source][i].amount >= Config.antiFarm.maxAmount then -- if amount more than max
                return false
            end
            antifarm[source][i].amount += 1 -- if not amount more than max
            antifarm[source][i].time = curentTime
            return true
        end
    end
    table.insert(antifarm[source],{time = curentTime, coords = coords, amount= 1}) -- if no table in coords found
    return true
end

function map(x, in_min, in_max, out_min, out_max)
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

--------------------------------Item-------------------------------------
if Config.Framework == 'qb-core' then
    QBCore.Functions.CreateUseableItem('huntingbait', function(source)
    	TriggerClientEvent('loyal-hunting:use-item', source, "huntingbait")
    end)

    QBCore.Functions.CreateUseableItem('huntingknife',function(source)
        TriggerClientEvent('loyal-hunting:use-item', source, "huntingknife")
    end)
else
    ESX.RegisterUsableItem('huntingbait', function(source)
        TriggerClientEvent('loyal-hunting:use-item', source, "huntingbait")
    end)
    
    ESX.RegisterUsableItem('huntingknife',function(source)
        TriggerClientEvent('loyal-hunting:use-item', source, "huntingknife")
    end)
end

if Config.Inventory == 'ox_inventory' then
    RegisterServerEvent("loyal-hunting:removeItem")
    AddEventHandler("loyal-hunting:removeItem", function(item)
        local src = source
        exports.ox_inventory:RemoveItem(src, item, 1)
    end) 
    exports.ox_inventory:RegisterShop('HuntingShop', {
        name = 'Hunting shop',
        inventory = Config.OXShop,
    })
else
    RegisterServerEvent("loyal-hunting:removeItem")
    AddEventHandler("loyal-hunting:removeItem", function(item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src) 
        Player.Functions.RemoveItem(item, 1) 
    end) 
end
RegisterServerEvent("loyal-hunting:delete-ped")
AddEventHandler("loyal-hunting:delete-ped", function(ped)
    local xPed = NetworkGetEntityFromNetworkId(ped)
    if DoesEntityExist(xPed) then
        DeleteEntity(xPed)
    end
end)

