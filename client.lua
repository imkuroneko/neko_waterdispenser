local QBCore = exports['qb-core']:GetCoreObject()
lib.locale()

exports['qb-target']:AddTargetModel(Config.props, {
    options = {
        { type = 'client', event = 'neko_waterdispenser:take:drink_water', icon = Config.qbTargetIcon, label = locale('qbtarget_label') }
    },
    distance = Config.qbTargetDistance
})

RegisterNetEvent('neko_waterdispenser:take:drink_water')
AddEventHandler('neko_waterdispenser:take:drink_water', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
            local progressParams = {
                duration = Config.TimeInMS,
                label = locale('action'),
                useWhileDead = false,
                position = 'bottom',
                canCancel = true,
                disable = { car = true, move = true, combat = true },
                anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_c' },
                prop = { model = "prop_plastic_cup_02", bone = 28422, pos = { x = 0.022, y = 0.00, z = 0.025 }, rot = { x = 10.0, y = -0.0, z = 0.0 } }
            }

            if Config.VerifyNearby then
                local dispenserMachine = GetClosestWaterDispenser(Config.props)
                if dispenserMachine ~= nil then
                    DrinkWater(progressParams)
                else
                    lib.notify({ description = locale('not_available'), type = 'error' })
                end
            else
                DrinkWater(progressParams)
            end
        end
    end)
end)

function DrinkWater(params)
    if lib.progressCircle(params) then
        TriggerServerEvent('neko_waterdispenser:server:drinked_water')

        lib.notify({ description = locale('drinked_water_ok'), type = 'success' })
    else
        lib.notify({ description = locale('drinked_water_cancelled'), type = 'error' })
    end
end

function GetClosestWaterDispenser(props)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local object = nil
    for _, machine in pairs(props) do
        local ClosestObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.75, GetHashKey(machine), 0, 0, 0)
        if ClosestObject ~= 0 and ClosestObject ~= nil then
            if object == nil then
                object = ClosestObject
            end
        end
    end
    return object
end