local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

local Commands = {}

local API = {}

function API:AddCommand(trigger, callback, aliases)
    Commands[trigger:lower()] = callback
    if aliases then
        for _, alias in ipairs(aliases) do
            Commands[alias:lower()] = callback
        end
    end
end

local function onPlayerChatted(message)
    local msgLower = message:lower()
    for trigger, callback in pairs(Commands) do
        if msgLower:match(trigger) then
            task.spawn(callback, message)
        end
    end
end

LocalPlayer.Chatted:Connect(onPlayerChatted)

API:AddCommand("!rejoin", function()
    TeleportService:Teleport(PlaceId, LocalPlayer)
end, {"!rj"})

API:AddCommand("!infiniteYield", function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)
    if not success then
        warn("Failed to load Infinite Yield:", err)
    end
end, {"!iy"})

return API
