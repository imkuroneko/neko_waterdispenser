local QBCore = exports['qb-core']:GetCoreObject()

exports['qb-target']:AddTargetModel(Config.props, {
    options = { { type = 'client', event = 'neko_waterdispenser:take:cup', icon = Config.icon, label = Config.label } },
    distance = 2.0
})

RegisterNetEvent('neko_waterdispenser:take:cup')
AddEventHandler('neko_waterdispenser:take:cup', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
            local dispenserMachine = GetClosestWaterDispenser()
            if dispenserMachine ~= nil then
                TriggerServerEvent('QBCore:Server:AddItem', Config.itemName, 1)
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.itemName], "add")
                QBCore.Functions.Notify("Te has servido un poco de agua fresca", "success")
            end
        end
    end)
end)

function GetClosestWaterDispenser()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local object = nil
    for _, machine in pairs(Config.props) do
        local ClosestObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.75, GetHashKey(machine), 0, 0, 0)
        if ClosestObject ~= 0 and ClosestObject ~= nil then
            if object == nil then
                object = ClosestObject
            end
        end
    end
    return object
end