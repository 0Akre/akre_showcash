local QBCore = exports['qb-core']:GetCoreObject()
local nuiOpen = false
local lastType = nil
local closeTimer = nil

RegisterCommand("cash", function()
    if nuiOpen and lastType == "cash" then
        closeUI()
    else
        local PlayerData = QBCore.Functions.GetPlayerData()
        local cash = PlayerData.money["cash"] or 0

        SendNUIMessage({
            type = "show_cash",
            cash = cash
        })

        nuiOpen = true
        lastType = "cash"
        SetNuiFocus(false, false)
        startAutoCloseTimer()
    end
end, false)

RegisterCommand("bank", function()
    if nuiOpen and lastType == "bank" then
        closeUI()
    else
        local PlayerData = QBCore.Functions.GetPlayerData()
        local bank = PlayerData.money["bank"] or 0

        SendNUIMessage({
            type = "show_bank",
            bank = bank
        })

        nuiOpen = true
        lastType = "bank"
        SetNuiFocus(false, false)
        startAutoCloseTimer()
    end
end, false)

function startAutoCloseTimer()
    if closeTimer then
        KillTimer(closeTimer)
    end
    closeTimer = SetTimeout(15000, function()
        if nuiOpen then
            closeUI()
        end
    end)
end

function closeUI()
    SendNUIMessage({ type = "hide" })
    nuiOpen = false
    lastType = nil
    SetNuiFocus(false, false)
    if closeTimer then
        KillTimer(closeTimer)
        closeTimer = nil
    end
end