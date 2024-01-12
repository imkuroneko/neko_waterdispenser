local QBCore = exports['qb-core']:GetCoreObject()

exports['qb-target']:AddTargetModel(Config.props, {
    options = { { type = 'client', event = 'neko_waterdispenser:take:cup', icon = Config.icon, label = Config.label } },
    distance = 2.0
})

RegisterNetEvent('neko_waterdispenser:take:cup')
AddEventHandler('neko_waterdispenser:take:cup', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
            local dispenserMachine = GetClosestWaterDispenser(Config.props)
            if dispenserMachine ~= nil then
                QBCore.Functions.Progressbar(
                    'neko_waterdispenser_drink',
                    Config.labelAction,
                    Config.TimeInMS,
                    false,
                    true,
                    { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true },
                    { animDict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c" },
                    { model = "prop_plastic_cup_02", bone = 28422, coords = { x = 0.022, y = 0.00, z = 0.025 }, rotation = { x = 10.0, y = -0.0, z = 0.0 } },
                    {},
                    function()
                        StopAnimTask(PlayerPedId(), "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
                        TriggerServerEvent('neko_waterdispenser:server:thirst')
                    end,
                    function()
                        StopAnimTask(PlayerPedId(), "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
                    end
                )
            else
                QBCore.Functions.Notify(Config.OutOfService, "error")
            end
        end
    end)
end)

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