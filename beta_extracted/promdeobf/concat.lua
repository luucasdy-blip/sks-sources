local Env = getfenv();
local Q = {};
local v1 = {...};
local r1 = true;
local r2 = string.gmatch;
local function r3(...)
    error("Tamper Detected!");
    return; 
end;
local r4 = false;
local v2 = pcall(function(...)
    r4 = true;
    return; 
end);
local v3 = v2;
if v2 then
    v3 = r4;
end;
local v4 = 1;
local r5 = math.random;
local v5 = table.concat;
local function v6(...)
    while true do
        l1 = l2;
        l2 = l1;
        r3(); 
    end;
    return; 
end;
local r6 = table and table.unpack or unpack;
local r7 = r5(3, 65);
local v7 = {
    pcall(function(...)
        return "pFmZ9yy" / (10829724 - "0Xdi6HZ1" ^ 1082860); 
    end)
};
local v8 = v7[2];
local v9 = tonumber;
local r8 = v9(r2(tostring(v8), ":(%d*):")());
for v = 1, r7 do
    r9 = v;
    r10 = math.random(1, 100);
    r11 = r5(0, 255);
    r12 = r5(1, r10);
    r13 = r5(1, 2) == 1;
    r14 = v8.gsub(v8, ":(%d*):", ":" .. tostring(r5(0, 10000)) .. ":");
    v3 = pcall;
    b = {
        v3(function(...)
            if r5(1, 2) == 1 or r9 == r7 then
                r1 = r1 and r8 == tonumber(r2(tostring(({
                    pcall(function(...)
                        return "gqa9" / (5862608 - "6Oh5Z72A" ^ 9448480); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for A = 1, r10 do
                v1[A] = r5(0, 255); 
            end;
            v1[r12] = r11;
            return r6(v1); 
        end)
    };
    v9 = r13;
    if v9 then
        v3 = r1;
        r1 = v3 and v9;
    end; 
end;
r1 = r1 and 0 == 0;
if r1 then
    v7 = {};
    r15 = math.floor;
    r16 = 0;
    r17 = 2;
    r18 = {};
    H = 0;
    for F = 1, 256 do
        v7[F] = F; 
    end;
    v8 = #v7 == 0;
    F = table.remove(v7, math.random(1, #v7));
    r18[F] = string.char(F - 1);
    if #v7 == 0 then
        r19 = {};
        r21 = {};
        f = setmetatable({}, {
            ["__index"] = r21,
            ["__metatable"] = nil
        });
        N = {
            "Lua",
            "is",
            "awesome"
        };
        print(table.concat(N, " "));
        print(table.concat(N, ", "));
        return;
    end;
end;
return (function(...)
    while true do
        l1 = l2;
        l2 = l1;
        r3(); 
    end;
    return; 
end)();