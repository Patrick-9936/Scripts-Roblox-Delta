-- made by ChatGPT: auto-finder of vulnerable remotes + GUI trigger
local uis = game:GetService("UserInputService")
local players = game:GetService("Players")
local player = players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "RemoteCrashGui"
local button = Instance.new("TextButton", gui)

button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0, 20, 0, 100)
button.BackgroundColor3 = Color3.new(1, 0.2, 0.2)
button.TextColor3 = Color3.new(1, 1, 1)
button.Text = "💥 Атаковать всех"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 22
button.BorderSizePixel = 0

local remotes = {}

local function scan_remotes()
    remotes = {}
    local function check(obj)
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local success, result = pcall(function()
                if obj:IsA("RemoteEvent") then
                    obj:FireServer()
                elseif obj:IsA("RemoteFunction") then
                    obj:InvokeServer()
                end
            end)

            if success then
                table.insert(remotes, obj)
                print("[✅ Работает]:", obj:GetFullName())
            else
                warn("[❌ Ошибка]:", obj:GetFullName(), result)
            end
        end
    end

    for _, container in ipairs({
        game:GetService("ReplicatedStorage"),
        game:GetService("Workspace"),
        game:GetService("Players"),
        game
    }) do
        for _, obj in ipairs(container:GetDescendants()) do
            check(obj)
        end
    end
end

-- запуск поиска сразу
scan_remotes()

-- функция при нажатии
button.MouseButton1Click:Connect(function()
    for _, remote in ipairs(remotes) do
        task.spawn(function()
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer()
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer()
                end
            end)
        end)
    end
    print("✅ Повторно активированы все рабочие Remotes")
end)
