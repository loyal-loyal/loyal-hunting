lib.locale()
local carryCarcass = 0
local heaviestCarcass = 0
QBCore = exports[Config.Core]:GetCoreObject()

local animals = {}
local listItemCarcass= {}
local CarcassByItem= {}
for key, value in pairs(Config.carcass) do
    table.insert(animals, key)
    table.insert(listItemCarcass, value)
    CarcassByItem[value] = key
end

exports['qb-target']:AddTargetModel(animals, {
    options = {
    {   icon = "fa-solid fa-paw",
        label = locale('pickup_carcass'),
        item = 'huntingknife',
        action = function (entity)
            local retval, bone = GetPedLastDamageBone(entity)
            TaskTurnPedToFaceEntity(PlayerPedId(), entity, -1)
            Wait(500)
            local found, player = GetClosestPlayerMenu()
            if not isValidZone() then
                QBCore.Functions.Notify(locale('cant_hun'), "error")
                return
            end
            if found then
                QBCore.Functions.Notify(locale('near_human'), "error")
                return
            end
            QBCore.Functions.Progressbar("pickup_carcass", locale('pickup_carcass'), 3000, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = false,
            }, {
                animdict = 'amb@medic@standing@kneel@idle_a',
                    anim = 'idle_a',
                    flag = 1,
            }, {}, {}, function()
                TriggerServerEvent('loyal-hunting:harvestCarcass',NetworkGetNetworkIdFromEntity(entity),bone)
            end)
        end,
        canInteract = function (entity)
            return IsEntityDead(entity) 
            -- return IsEntityDead(entity) and not IsEntityAMissionEntity(entity)
        end,
    } },
    distance = 2.0
})

Citizen.CreateThread(function ()
    Wait(60000)

    while true do
        Wait(1000)
        FreezeEntityPosition(playerPed, false)
        heaviestCarcass = 0
        for key, value in pairs(listItemCarcass) do
            if exports[Config.Inventory]:HasItem(value..'1',1) or exports[Config.Inventory]:HasItem(value..'2',1) or exports[Config.Inventory]:HasItem(value..'3',1) then
                heaviestCarcass = CarcassByItem[value]
                break
            end
        end
    if heaviestCarcass ~= 0 then
        if carryCarcass==0 then
        lib.requestModel(heaviestCarcass)
        DeleteEntity(carryCarcass)
        carryCarcass = CreatePed(1, heaviestCarcass, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
        SetEntityInvincible(carryCarcass, true)
        SetEntityHealth(carryCarcass, 0)
        local pos = Config.carcassPos[heaviestCarcass]
        AttachEntityToEntity(carryCarcass, PlayerPedId(),11816, pos.xPos, pos.yPos, pos.zPos, pos.xRot, pos.yRot, pos.zRot, false, false, false, true, 2, true)
        PlayCarryAnim()
        elseif GetEntityModel(carryCarcass)~=heaviestCarcass then
            DeleteEntity(carryCarcass)
            carryCarcass = 0
            ClearPedSecondaryTask(PlayerPedId())
            Wait(100)
            lib.requestModel(heaviestCarcass)
            DeleteEntity(carryCarcass)
            carryCarcass = CreatePed(1, heaviestCarcass, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
            SetEntityInvincible(carryCarcass, true)
            SetEntityHealth(carryCarcass, 0)
            local pos = Config.carcassPos[heaviestCarcass]
            AttachEntityToEntity(carryCarcass, PlayerPedId(),11816, pos.xPos, pos.yPos, pos.zPos, pos.xRot, pos.yRot, pos.zRot, false, false, false, true, 2, true)
            PlayCarryAnim()
        end
    else
        DeleteEntity(carryCarcass)
        carryCarcass = 0
        ClearPedSecondaryTask(PlayerPedId())
    end
    end
end)

IsPlayCarryAnim =false
function PlayCarryAnim()
    if carryCarcass ~= 0 and not IsPlayCarryAnim then
        if Config.carcassPos[heaviestCarcass].drag then
            lib.requestAnimDict('combat@drag_ped@')
            TaskPlayAnim(PlayerPedId(), 'combat@drag_ped@', 'injured_drag_plyr', 2.0, 2.0, 100000, 1, 0, false, false, false)
            CustomControl()

            Citizen.CreateThread(function ()
            IsPlayCarryAnim=true
            while carryCarcass ~= 0 do
                while not IsEntityPlayingAnim(PlayerPedId(), 'combat@drag_ped@', 'injured_drag_plyr', 1) do
                    TaskPlayAnim(PlayerPedId(), 'combat@drag_ped@', 'injured_drag_plyr', 2.0, 2.0, 100000, 1, 0, false, false, false)
                    Wait(0)
                end
                Wait(500)
            end
            IsPlayCarryAnim=false
            end)
        else
            lib.requestAnimDict('missfinale_c2mcs_1')
            TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
            Citizen.CreateThread(function ()
            IsPlayCarryAnim=true
            while carryCarcass ~= 0 do
                while not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 49) do
                    TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
                    Wait(0)
                end
                Wait(500)
            end
            IsPlayCarryAnim=false
            end)
        end
    else
        ClearPedSecondaryTask(PlayerPedId())
    end
end
isCustomControl= false
function CustomControl()
    if isCustomControl then return end
    Citizen.CreateThread(function ()
        local playerPed = PlayerPedId()
        local enable = true
        isCustomControl = true
        while enable do
            if IsControlPressed(0, 35) then -- Right
                FreezeEntityPosition(playerPed, false)
                SetEntityHeading(playerPed, GetEntityHeading(playerPed)+0.5)
            elseif IsControlPressed(0, 34) then -- Left
                FreezeEntityPosition(playerPed, false)
                SetEntityHeading(playerPed, GetEntityHeading(playerPed)-0.5)
            elseif IsControlPressed(0, 32) or IsControlPressed(0, 33) then
                FreezeEntityPosition(playerPed, false)
            else
                FreezeEntityPosition(playerPed, true)
                TaskPlayAnim(PlayerPedId(), 'combat@drag_ped@', 'injured_drag_plyr', 0.0, 0.0, 1, 2, 7, false, false, false)
            end
            Wait(7)
            if heaviestCarcass ~= 0 then
                enable = Config.carcassPos[heaviestCarcass].drag
            else
                enable = false
            end
        end
        isCustomControl = false
        FreezeEntityPosition(playerPed, false)
        ClearPedSecondaryTask(playerPed)
        ClearPedTasksImmediately(playerPed)
    end)
end


--------------------- SELL -----------------------------------

exports['qb-target']:AddBoxZone('loyal-hunting_sell', vector3(963.34, -2115.39, 31.47), 6.8, 1, {
    name="loyal-hunting_sell",
    heading=355,
    --debugPoly=true,
    minZ=31.27,
    maxZ=34.67
	}, {
		options = {
			{   icon = "fa-solid fa-sack-dollar",
                label = locale('sell_carcass'),
				action = function ()
                    QBCore.Functions.Progressbar("sell_in_progress", locale('sell_in_progress'), 3000, false, false, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = false,
                    }, {}, {}, {}, function()
                        TriggerServerEvent('loyal-hunting:SellCarcass', Config.carcass[heaviestCarcass])
                    end)
                end,
                canInteract= function ()
                    return heaviestCarcass ~= 0
                end
			},
		},
		distance = 2.0
})

Citizen.CreateThread(function ()
    blip = AddBlipForCoord(963.34, -2115.39)
	SetBlipSprite(blip, 141)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 43)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(locale'blip_name')
	EndTextCommandSetBlipName(blip)
end)

--------------------- BAIT -----------------------------------

local baitLocation = nil
local baitLastPlaced = 0

local baitDistanceInUnits = 40
local spawnDistanceRadius = 30
local validHuntingZones = {
    ["Paleto Forest"] = true,
    ["Raton Canyon"] = true,
    ["Mount Chiliad"] = true,
    ["Cassidy Creek"] = true
}

local HuntingAnimals = {
    'a_c_boar',
    --'a_c_cat_01',
    'a_c_chickenhawk',
    -- 'a_c_chimp',
    --'a_c_chop',
    'a_c_cormorant',
    --'a_c_cow',
    'a_c_coyote',
    --'a_c_crow',
    'a_c_deer',
    --'a_c_hen',
    --'a_c_husky',
    'a_c_mtlion',
    -- 'a_c_pig',
    --'a_c_pigeon',
    --'a_c_poodle',
    --'a_c_pug',
    'a_c_rabbit_01',
    --'a_c_rat',
    --'a_c_retriever',
    --'a_c_rhesus',
    --'a_c_rottweiler',
    --'a_c_seagull',
    --'a_c_shepherd',
    --'a_c_westy',
    -- 'a_c_panther' 
}

local animals = {
    {model = "a_c_deer", hash = -664053099, item = "meatdeer", id = 35},
    {model = "a_c_pig", hash = -1323586730, item = "meatpig", id = 36},
    {model = "a_c_boar", hash = -832573324, item = "meatboar", id = 37},
    {model = "a_c_mtlion", hash = 307287994, item = "meatlion",id = 38},
    {model = "a_c_cow", hash = -50684386, item = "meatcow", id = 39},
    {model = "a_c_coyote", hash = 1682622302, item = "meatcoyote", id = 40},
    {model = "a_c_rabbit_01", hash = -541762431, item = "meatrabbit", id = 41},
    {model = "a_c_pigeon", hash = 111281960, item = "meatbird", id = 42},
    {model = "a_c_seagull", hash = -745300483, item = "meatseagull", id = 43},
	{model = "a_c_cormorant", hash = 1457690978, item = "meatcormorant", id = 44},
	{model = "a_c_chickenhawk", hash = -1430839454, item = "meatchickenhawk", id = 45},
	{model = "a_c_crow", hash = 402729631, item = "meatcrow", id = 46},
	
}

exports("huntingArea", function()
    return validHuntingZones
end)

DecorRegister("HuntingMySpawn", 2)


RegisterNetEvent('QBCore:Player:UpdatePlayerData')
AddEventHandler('QBCore:Player:UpdatePlayerData', function()
    local data = {}
    data.position = QBCore.Functions.GetCoords(PlayerPedId())
    TriggerServerEvent('QBCore:UpdatePlayer', data)
end)


function GetEntityPlayerIsLookingAt(pDistance, pRadius, pFlag, pIgnore)
    local distance = pDistance or 3.0
    local originCoords = GetPedBoneCoords(PlayerPedId(), 31086)
    local forwardVectors = GetForwardVector(GetGameplayCamRot(2))
    local forwardCoords = originCoords + (forwardVectors * (IsInVehicle and distance + 1.5 or distance))

    if not forwardVectors then return end

    local _, hit, targetCoords, _, targetEntity = RayCast(originCoords, forwardCoords, pFlag or 286, pIgnore, pRadius or 0.2)

    if not hit and targetEntity == 0 then return end

    local entityType = GetEntityType(targetEntity)

    return targetEntity, entityType, targetCoords
end

function GetForwardVector(rotation)
    local rot = (math.pi / 180.0) * rotation
    return vector3(-math.sin(rot.z) * math.abs(math.cos(rot.x)), math.cos(rot.z) * math.abs(math.cos(rot.x)), math.sin(rot.x))
end

function RayCast(origin, target, options, ignoreEntity, radius)
    local handle = StartShapeTestSweptSphere(origin.x, origin.y, origin.z, target.x, target.y, target.z, radius, options, ignoreEntity, 0)
    return GetShapeTestResult(handle)
end


function isValidZone()
    return validHuntingZones[GetLabelText(GetNameOfZone(GetEntityCoords(PlayerPedId())))] == true
end

local function getSpawnLoc()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local spawnCoords = nil
    while spawnCoords == nil do
        local spawnX = math.random(-spawnDistanceRadius, spawnDistanceRadius)
        local spawnY = math.random(-spawnDistanceRadius, spawnDistanceRadius)
        local spawnZ = baitLocation.z
        local vec = vector3(baitLocation.x + spawnX, baitLocation.y + spawnY, spawnZ)
        if #(playerCoords - vec) > spawnDistanceRadius then
            spawnCoords = vec
        end
    end
    local worked, groundZ, normal = GetGroundZAndNormalFor_3dCoord(spawnCoords.x, spawnCoords.y, 1023.9)
    spawnCoords = vector3(spawnCoords.x, spawnCoords.y, groundZ)
    return spawnCoords
end 

local function spawnAnimal(loc) 
    local foundAnimal = false  
    local animal = HuntingAnimals[math.random(#HuntingAnimals)]
    local hash = GetHashKey(animal)
    RequestModel(hash)
    while not HasModelLoaded(hash) do 
        Citizen.Wait(0)
    end
    local spawnLoc = getSpawnLoc()
    local spawnedAnimal = CreatePed(28, animal, spawnLoc, true, true, true)
    DecorSetBool(spawnedAnimal, "HuntingMySpawn", true)
    SetModelAsNoLongerNeeded(modelName)
    TaskGoStraightToCoord(spawnedAnimal, loc, 1.0, -1, 0.0, 0.0)
    Citizen.CreateThread(function()
        local finished = false
        while not IsPedDeadOrDying(spawnedAnimal) and not finished do
            local spawnedAnimalCoords = GetEntityCoords(spawnedAnimal)
            if #(loc - spawnedAnimalCoords) < 0.5 then
                ClearPedTasks(spawnedAnimal)
                Citizen.Wait(1500)
                TaskStartScenarioInPlace(spawnedAnimal, "WORLD_DEER_GRAZING", 0, true)
                Citizen.SetTimeout(7500, function()
                    finished = true
                end)
            end
            if #(spawnedAnimalCoords - GetEntityCoords(PlayerPedId())) < 15.0 then
                ClearPedTasks(spawnedAnimal)
                TaskSmartFleePed(spawnedAnimal, PlayerPedId(), 600.0, -1)
                finished = true
            end
            Citizen.Wait(1000)
        end
        if not IsPedDeadOrDying(spawnedAnimal) then
            TaskSmartFleePed(spawnedAnimal, PlayerPedId(), 600.0, -1)
        end
    end)
end

local function baitDown()
    Citizen.CreateThread(function()
        while baitLocation ~= nil do
            if #(baitLocation - GetEntityCoords(PlayerPedId())) > baitDistanceInUnits then
                if math.random() < 0.15 then
                    spawnAnimal(baitLocation)
                    baitLocation = nil
                end
            end
            Citizen.Wait(5000)
        end
    end)
end
local bussy = true
local lastTime = GetGameTimer() + 3000
local lastAnimals = {}

function removeEntity(entity)
    local delidx = 0

    for i = 1, #lastAnimals do
        if (lastAnimals[i].entity == entity) then delidx = i end
    end

    if (delidx > 0) then table.remove(lastAnimals, delidx) end
end

function lastAnimalExists(entity)
    for _, v in pairs(lastAnimals) do
        if (v.entity == entity) then return true end
    end
end


RegisterNetEvent('loyal-hunting:use-item')
AddEventHandler('loyal-hunting:use-item', function(item)
    if GetGameTimer() > lastTime then
        lastTime = GetGameTimer() + 3000
        if item == "huntingbait" then
            if not isValidZone() then
                QBCore.Functions.Notify(locale('cant_hun'), "error")
                return
            end
            if baitLastPlaced ~= 0 and GetGameTimer() < (baitLastPlaced + Config.CoolDownBait * 1000) then 
                QBCore.Functions.Notify(locale('cooldown_bait')..Config.CoolDownBait..'seconds!', "error")
                return
            end
            if bussy then
                bussy = false
                baitLocation = nil
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
				TriggerServerEvent("loyal-hunting:removeItem", item)
                QBCore.Functions.Progressbar("placing_bait", locale('bait'), 15000, false, true, { 
                    disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
                }, {}, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    baitLastPlaced = GetGameTimer()
                    baitLocation = GetEntityCoords(PlayerPedId())
                    QBCore.Functions.Notify(locale('baited'))
                    
                    baitDown()
                    bussy = true 
                end, function() -- Cancel
                    bussy = true
                end)
            end
        end
    else
        QBCore.Functions.Notify(locale('cooldown_bait')..Config.CoolDownBait..'seconds!', "error")
    end
end)

function GetClosestPlayerMenu()
	local player, distance = QBCore.Functions.GetClosestPlayer()
	if distance ~= -1 and distance <= 5.0 then
		return true, GetPlayerServerId(player)
	else
		return false
	end
end 


-------------------shop--------------------------------------
local pedSpawned = false

Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel("ig_hunter", {
        options = {
            {
                type = "client",
                event = "loyal-hunting:shop",
                icon = "fas fa-leaf",
                label = "Shop",
            },
        },
        distance = 4.0
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local dst = #(Config.PedCoords - pedCoords) 
        if dst < 40 and pedSpawned == false then
            TriggerEvent('loyal-hunting:spawnJobPed', Config.PedCoords, Config.PedCoordsHeading)
            pedSpawned = true
        end
        if dst >= 41  then
            if DoesEntityExist(jobPed) then
                DeletePed(jobPed)
            end
        pedSpawned = false
        end
    end
end)

RegisterNetEvent('loyal-hunting:spawnJobPed')
AddEventHandler('loyal-hunting:spawnJobPed',function(coords, heading)
    local hash = Config.PedHash
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    jobPed = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(jobPed, true)
    SetEntityInvincible(jobPed, true)
    SetBlockingOfNonTemporaryEvents(jobPed, true)
    SetModelAsNoLongerNeeded(hash)
end)

RegisterNetEvent('loyal-hunting:shop')
AddEventHandler('loyal-hunting:shop',function()  
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "hunting", Config.Items)
end)

----------------------block fire human----------------------------
local hasHuntingRifle = false
local isFreeAiming = false
local function processScope(freeAiming)
    if not isFreeAiming and freeAiming then
        isFreeAiming = true
        SendNUIMessage({
            display = true,
        })
    elseif isFreeAiming and not freeAiming then
        isFreeAiming = false
        SendNUIMessage({
            display = false,
        })
    end
end

local blockShotActive = false
local function blockShooting()
    if blockShotActive then return end
    blockShotActive = true
    Citizen.CreateThread(function()
        while hasHuntingRifle do
            local ply = PlayerId()
            local ped = PlayerPedId()
            local ent = nil
            local aiming, ent = GetEntityPlayerIsFreeAimingAt(ply)
            local freeAiming = IsPlayerFreeAiming(ply)
            processScope(freeAiming)
            local et = GetEntityType(ent)
            if not freeAiming
                or IsPedAPlayer(ent)
                or et == 2
                or (et == 1 and IsPedInAnyVehicle(ent))
            then
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 58, true)
                DisablePlayerFiring(ped, true)
            end
            Citizen.Wait(0)
        end
        blockShotActive = false
        processScope(false)
    end)
end

Citizen.CreateThread(function()
    local huntingRifleHash = `weapon_sniperrifle` -- -646649097

    while true do
        if GetSelectedPedWeapon(PlayerPedId()) == huntingRifleHash then
            hasHuntingRifle = true
            blockShooting()
        else
            hasHuntingRifle = false
        end
        Citizen.Wait(1000)
    end
end)

