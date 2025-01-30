local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-core:getPlayerMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local cash = Player.PlayerData.money["cash"]
        local bank = Player.PlayerData.money["bank"]
        cb(cash, bank)
    else
        cb(0, 0)
    end
end)
