local Env = getfenv();
local S = {};
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
end) and r4;
local r5 = math.random;
local v3 = table.concat;
local function v4(...)
    while true do
        l1 = l2;
        l2 = l1;
        r3(); 
    end;
    return; 
end;
local v5 = table;
if v5 then
    h = table.unpack;
end;
local v6 = v3;
local r6 = v5 or unpack;
local r7 = r5(3, 65);
local v7 = {
    pcall(function(...)
        return "IOiSSZo6tP5K1sq" / (5132098 - "0S39LtIZMi6Nn" ^ 274510); 
    end)
};
local v8 = v7[2];
local r8 = tonumber(r2(tostring(v8), ":(%d*):")());
for q = 1, r7 do
    r9 = q;
    r10 = math.random(1, 100);
    r11 = r5(0, 255);
    r12 = r5(1, r10);
    r13 = r5(1, 2) == 1;
    r14 = v8.gsub(v8, ":(%d*):", ":" .. tostring(r5(0, 10000)) .. ":");
    f = {
        pcall(function(...)
            if r5(1, 2) == 1 or r9 == r7 then
                r1 = r1 and r8 == tonumber(r2(tostring(({
                    pcall(function(...)
                        return "tQNqgdwgXPc" / (10525601 - "DYpx" ^ 9817341); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for U = 1, r10 do
                v1[U] = r5(0, 255); 
            end;
            v1[r12] = r11;
            return r6(v1); 
        end)
    };
    if r13 then
        r1 = r1 and (pcall(function(...)
            if r5(1, 2) == 1 or r9 == r7 then
                r1 = r1 and r8 == tonumber(r2(tostring(({
                    pcall(function(...)
                        return "tQNqgdwgXPc" / (10525601 - "DYpx" ^ 9817341); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for U = 1, r10 do
                v1[U] = r5(0, 255); 
            end;
            v1[r12] = r11;
            return r6(v1); 
        end) == false and f[2] == r14);
    end; 
end;
r1 = r1 and 0 == 0;
if r1 then
    v7 = {};
    r15 = math.floor;
    r16 = 0;
    r17 = 2;
    r18 = {};
    v5 = 0;
    for F = 1, 256 do
        v7[F] = F; 
    end;
    v8 = #v7 == 0;
    F = table.remove(v7, math.random(1, #v7));
    r18[F] = string.char(F - 1);
    if #v7 == 0 then
        r19 = {};
        r21 = {};
        y = setmetatable({}, {
            ["__index"] = r21,
            ["__metatable"] = nil
        });
        if true then
            v2 = true == true;
        end;
        v6 = S[y];
        if true then
            print("done");
        end;
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