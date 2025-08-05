-- ⚠️ Server Crash Script for BABFT by Патрик
-- Работает глобально, влияет на всех игроков

local workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- 1. Разрушает всю карту: сброс joint‑соединений, отлет частей
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        task.spawn(function()
            pcall(function()
                obj:BreakJoints()
                obj.CanCollide = true
                obj.Velocity = Vector3.new(math.random(-500, 500), math.random(500, 1500), math.random(-500, 500))
            end)
        end)
    end
end

-- 2. Постоянный спам «touch interest» для физ.каша и лагов
RunService.Heartbeat:Connect(function()
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and math.random() < 0.01 then
            local center = part.Position
            for i = 1, 3 do
                part.Velocity = Vector3.new(math.random(-800, 800), math.random(-800, 800), math.random(-800, 800))
            end
        end
    end
end)
