-- [[ QBCORE ]] --
local QBCore = exports['qb-core']:GetCoreObject()

-- [[ Variables ]] --
local nuiOpen = false
local autoClose, keyMapping = true, true

-- [[ Functions ]] --
local function ToggleNUI()
    local PlayerData = QBCore.Functions.GetPlayerData()
    
    if nuiOpen then
        SendNUIMessage({ type = "hide" })
        nuiOpen = false
    else
        SendNUIMessage({
            type = "show_money",
            cash = PlayerData.money["cash"],
            bank = PlayerData.money["bank"]
        })
        nuiOpen = true
    end
end

-- [[ Other ]] -- 
RegisterCommand("money", function()
    ToggleNUI()
    if autoClose then 
        Wait(5000) 
        ToggleNUI() 
    end
end, false)
if keyMapping then RegisterKeyMapping("money", 'Shows cash and bank totals', "keyboard", "z") end

-- [[ NUI Callbacks ]] --
RegisterNUICallback("closeNUI", function()
    nuiOpen = false
end)
