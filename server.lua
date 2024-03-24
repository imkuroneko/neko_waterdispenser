local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('neko_waterdispenser:server:drinked_water', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local newThirst = (Player.PlayerData.metadata.thirst + Config.amountThirst)
    Player.Functions.SetMetaData('thirst', newThirst)
    TriggerClientEvent('hud:client:UpdateNeeds', source, Player.PlayerData.metadata.hunger, newThirst)
end)