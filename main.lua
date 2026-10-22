-- [[ PROJECT: Classic Retro Craftwars - Elite Customizable Hub ]]
-- [[ ЧАСТЬ 3 ИЗ 4: Автоклики и Сверх-прожим Способностей ]]

local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local player = game:GetService("Players").LocalPlayer

local inputKeys = {Enum.KeyCode.E, Enum.KeyCode.Q, Enum.KeyCode.R, Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.F}
local abilityKeys = {"Z", "X", "C", "V", "F", "E", "Q"}

task.spawn(function()
    while true do
        if _G.CheatConfig.MainFarmActive and not _G.FarmState.IsFlyingToButtons then
            if _G.CheatConfig.SpamKeysActive then
                for _, key in ipairs(inputKeys) do
                    pcall(function() VirtualUser:SetKeyDown(key) RunService.Heartbeat:Wait() VirtualUser:SetKeyUp(key) end)
                end
            end
            if _G.CheatConfig.ScreenClickActive then
                pcall(function() VirtualUser:Button1Down(Vector2.new(100, 100)) RunService.Heartbeat:Wait() VirtualUser:Button1Up(Vector2.new(100, 100)) end)
            end
        end
        task.wait(_G.CheatConfig.ClickDelay) 
    end
end)

task.spawn(function()
    while true do
        if _G.CheatConfig.AntiAfkActive then pcall(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new(0,0)) end) end
        task.wait(_G.CheatConfig.AntiAfkDelay)
    end
end)

local function ClickScreenAbilityButtons()
    if not _G.CheatConfig.AutoAbilitiesActive then return end
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return end

    for _, guiObj in ipairs(playerGui:GetDescendants()) do
        if guiObj:IsA("TextButton") or guiObj:IsA("ImageButton") then
            local nameLower = string.lower(guiObj.Name)
            local textLower = guiObj:IsA("TextButton") and string.lower(guiObj.Text) or ""
            
            if string.find(nameLower, "heart") or string.find(nameLower, "bleed") or 
               string.find(nameLower, "skill") or string.find(nameLower, "ability") or 
               string.find(textLower, "heart") or string.find(nameLower, "spell") or
               nameLower == "x" or nameLower == "z" or nameLower == "c" then
                
                if _G.CheatConfig.UseVirtualClickAbilities then pcall(function() guiObj:Activate() end) end
                if _G.CheatConfig.UseRemoteAbilities then
                    pcall(function()
                        local events = guiObj:FindFirstChildOfClass("RemoteEvent") or guiObj:FindFirstChildOfClass("BindableEvent")
                        if events then events:FireServer() end
                    end)
                end
            end
        end
    end
    if _G.CheatConfig.UseKeyPressAbilities then
        pcall(function() for _, keyStr in ipairs(abilityKeys) do VirtualUser:TypeKey(keyStr) end end)
    end
end

task.spawn(function()
    while true do
        if _G.CheatConfig.AutoAbilitiesActive then ClickScreenAbilityButtons() end
        task.wait(0.05)
    end
end)
print("[Elite Hub]: Часть 3 успешно загружена!")
