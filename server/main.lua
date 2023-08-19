lib.locale()
local antifarm = {}
QBCore = exports['qb-core']:GetCoreObject()

-- lib.versionCheck('N-fire/loyal-hunting')
-- if not lib.checkDependency('ox_lib', '2.1.0') then error('You don\'t have latest version of ox_lib') end
-- if not lib.checkDependency('ox_inventory', '2.7.4') then error('You don\'t have latest version of ox_inventory') end
-- if not lib.checkDependency('qtarget', '2.1.0') then error('You don\'t have latest version of qtarget') end


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
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.AddItem(item..grade, 1)
			    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item..grade], "add",1)
                DeleteEntity(entity)
        else
            TriggerClientEvent('QBCore:Notify', source, locale('stop_farm'), "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, locale('too_far'), "error")
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

-- lib.addCommand('group.admin', 'giveCarcass', function(source, args)
--     for key, value in pairs(Config.carcass) do
--         exports.ox_inventory:AddItem(source, value, 1, {type = '★☆☆', image =  value..1})
--         exports.ox_inventory:AddItem(source, value, 1, {type = '★★☆', image =  value..2})
--         exports.ox_inventory:AddItem(source, value, 1, {type = '★★★', image =  value..3})
--     end
-- end)

-- lib.addCommand('group.admin', 'spawnPed', function(source, args)
--     local playerCoords = GetEntityCoords(GetPlayerPed(source))
--     local entity = CreatePed(0, GetHashKey(args.hash), playerCoords, true, true)
-- end,{'hash:string'})

-- lib.addCommand('group.admin', 'printAntifarm', function(source, args)
--     print(json.encode(antifarm,{indent = true}))
-- end)

-- lib.addCommand('group.admin', 'printInv', function(source, args)
--     print(json.encode(exports.ox_inventory:Inventory(source).items,{indent = true}))
-- end)

RegisterNetEvent('qb-fishing:server:RemoveBait', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.RemoveItem('huntingbait', 1) then
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['huntingbait'], 'remove', 1)
    end
end)

-- hunting

QBCore.Functions.CreateUseableItem('huntingbait', function(source)
	TriggerClientEvent('qb-hunting:use-item', source, "huntingbait")
end)

QBCore.Functions.CreateUseableItem('huntingknife',function(source)
    TriggerClientEvent('qb-hunting:use-item', source, "huntingknife")
end)

RegisterServerEvent("qb-hunting:removeItem")
AddEventHandler("qb-hunting:removeItem", function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem(item, 1) 
end) 

RegisterServerEvent("qb-hunting:delete-ped")
AddEventHandler("qb-hunting:delete-ped", function(ped)
    local xPed = NetworkGetEntityFromNetworkId(ped)
    if DoesEntityExist(xPed) then
        DeleteEntity(xPed)
    end
end)

