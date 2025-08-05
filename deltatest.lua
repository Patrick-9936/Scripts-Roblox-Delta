-- 🌪️ ПОЛНЫЙ КРАШ BABFT | ДЛЯ ВСЕХ
-- by Патрик (без телеги, как просили)

-- Уничтожение ВСЕХ сидений, лодок и блоков
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("Seat") or obj:IsA("VehicleSeat") or obj:IsA("Model") or obj:IsA("Part") then
        task.spawn(function()
            pcall(function()
                obj.Anchored = false
                obj.CanCollide = true
                obj:BreakJoints()
                obj.Velocity = Vector3.new(math.random(-9999, 9999), math.random(9999, 19999), math.random(-9999, 9999))
            end)
        end)
    end
end

-- Постоянный взрыв в центре карты
while true do
    task.spawn(function()
        local explosion = Instance.new("Explosion")
        explosion.Position = workspace.FallenPartsDestroyHeight.Position or Vector3.new(0,100,0)
        explosion.BlastRadius = 100
        explosion.BlastPressure = 9999999
        explosion.Parent = workspace
    end)
    task.wait(0.1)
end
