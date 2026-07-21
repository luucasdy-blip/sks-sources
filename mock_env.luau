-- Minimal Roblox mock for Lune
local process = require("@lune/process")
local fs = require("@lune/fs")
local luau = require("@lune/luau")

local args = process.args
if #args < 1 then
    print("Usage: lune run <this> <input.lua> [output.lua]")
    process.exit(1)
end

local input = args[1]
local output = args[2] or "decoded.lua"

local ok, source = pcall(fs.readFile, input)
if not ok then print("Failed to read:", input) process.exit(1) end

-- Build a minimal mock environment with all needed functions
local env = {}

-- Standard Lua libraries
env.print = print
env.warn = warn
env.type = type
env.tostring = tostring
env.tonumber = tonumber
env.pairs = pairs
env.ipairs = ipairs
env.next = next
env.pcall = pcall
env.xpcall = xpcall
env.error = error
env.select = select
env.unpack = unpack or table.unpack
env.rawget = rawget
env.rawset = rawset
env.rawequal = rawequal
env.getmetatable = getmetatable
env.setmetatable = setmetatable
env.newproxy = newproxy

-- Roblox globals
env.game = newproxy(true)
local game_mt = getmetatable(env.game)
game_mt.__index = function(_, k)
    if k == "GetService" then
        return function(_, name)
            local svc = newproxy(true)
            local mt = getmetatable(svc)
            mt.__index = function(_, k2)
                if k2 == "LocalPlayer" then
                    local lp = newproxy(true)
                    local lp_mt = getmetatable(lp)
                    lp_mt.__index = function(_, k3)
                        if k3 == "Name" then return "Player" end
                        if k3 == "UserId" then return 1 end
                        if k3 == "Character" then
                            local char = newproxy(true)
                            local char_mt = getmetatable(char)
                            char_mt.__index = function(_, k4)
                                if k4 == "HumanoidRootPart" then
                                    local hrp = newproxy(true)
                                    local hrp_mt = getmetatable(hrp)
                                    hrp_mt.__index = function() return newproxy(true) end
                                    return hrp
                                end
                                if k4 == "Humanoid" then return newproxy(true) end
                                return newproxy(true)
                            end
                            return char
                        end
                        return newproxy(true)
                    end
                    return lp
                end
                if k2 == "GetPlayers" then return function() return {} end end
                if k2 == "GetPlayerFromCharacter" then return function() return nil end end
                return newproxy(true)
            end
            mt.__tostring = function() return name end
            return svc
        end
    end
    if k == "HttpGet" or k == "HttpGetAsync" then
        return function(_, url) return "" end
    end
    if k == "PlaceId" then return 123456 end
    if k == "JobId" then return "deadbeef" end
    if k == "Players" then
        return env.game:GetService("Players")
    end
    return newproxy(true)
end
game_mt.__tostring = function() return "game" end

env.workspace = newproxy(true)
getmetatable(env.workspace).__index = function() return newproxy(true) end
getmetatable(env.workspace).__tostring = function() return "workspace" end

env.Players = env.game:GetService("Players")
env.RunService = env.game:GetService("RunService")
env.UserInputService = env.game:GetService("UserInputService")
env.CoreGui = env.game:GetService("CoreGui")
env.ReplicatedStorage = env.game:GetService("ReplicatedStorage")

env.Instance = newproxy(true)
getmetatable(env.Instance).__index = function(_, k)
    if k == "new" then
        return function(_, className)
            local inst = newproxy(true)
            local mt = getmetatable(inst)
            mt.__index = function(_, prop)
                if prop == "Parent" then return nil end
                if prop == "dummy" then return nil end
                return newproxy(true)
            end
            mt.__newindex = function() end
            return inst
        end
    end
    return newproxy(true)
end

env.task = {
    wait = function() return 0 end,
    spawn = function(f) pcall(f) end,
    defer = function(f) pcall(f) end,
    delay = function(n, f) pcall(f) end,
}

env.math = math
env.string = string
env.table = table
env.debug = debug
env.coroutine = coroutine
env.os = os
env.io = io

-- Executor functions
env.loadstring = function(s, n) return loadstring(s, n) end
env.getgenv = function() return env end
env.getrenv = function() return env end
env.identifyexecutor = function() return "MockExecutor", "1.0" end
env.checkcaller = function() return true end
env.isclosure = function() return false end
env.iscclosure = function() return true end
env.newcclosure = function(f) return f end
env.hookfunction = function(f, r) return r end
env.cloneref = function(r) return r end
env.getrawmetatable = function(t)
    local mt = getmetatable(t)
    if mt then return mt end
    return { __metatable = nil }
end
env.setreadonly = function() end
env.isreadonly = function() return false end
env.setrawmetatable = function(t, mt) return setmetatable(t, mt) end

-- Compile and run
local fn, err = luau.load(source, { environment = env })
if not fn then
    print("Compile error:", err)
    process.exit(1)
end

print("Running script...")
local ok2, err2 = pcall(fn)
if not ok2 then
    print("Runtime error:", err2)
end
print("Done.")
