local Env = getfenv();
local c = {};
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
local r6 = table and table.unpack or unpack;
local r7 = r5(3, 65);
local v5 = {
    pcall(function(...)
        return "n1E" / (3428677 - "aj" ^ 16026074); 
    end)
};
local v6 = v5[2];
local r8 = tonumber(r2(tostring(v6), ":(%d*):")());
for O = 1, r7 do
    r9 = O;
    r10 = math.random(1, 100);
    r11 = r5(0, 255);
    r12 = r5(1, r10);
    r13 = r5(1, 2) == 1;
    r14 = v6.gsub(v6, ":(%d*):", ":" .. tostring(r5(0, 10000)) .. ":");
    I = {
        pcall(function(...)
            if r5(1, 2) == 1 or r9 == r7 then
                r1 = r1 and r8 == tonumber(r2(tostring(({
                    pcall(function(...)
                        return "2MYE" / (16019497 - "KItD9m" ^ 14437799); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for r = 1, r10 do
                v1[r] = r5(0, 255); 
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
                        return "2MYE" / (16019497 - "KItD9m" ^ 14437799); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for r = 1, r10 do
                v1[r] = r5(0, 255); 
            end;
            v1[r12] = r11;
            return r6(v1); 
        end) == false and I[2] == r14);
    end; 
end;
r1 = r1 and 0 == 0;
if r1 then
    r17 = math.floor;
    v5 = {};
    r18 = 0;
    r19 = 2;
    r20 = {};
    l = 0;
    for S = 1, 256 do
        v5[S] = S; 
    end;
    v6 = #v5 == 0;
    S = table.remove(v5, math.random(1, #v5));
    r20[S] = string.char(S - 1);
    if #v5 == 0 then
        r21 = {};
        r23 = {};
        r16 = setmetatable({}, {
            ["__index"] = r23,
            ["__metatable"] = nil
        });
        r24 = game.Players.LocalPlayer;
        r = game;
        r25 = r.GetService(r, "UserInputService");
        v2 = game;
        r26 = v2.GetService(v2, "RunService");
        r27 = workspace.CurrentCamera;
        B = Instance.new("ScreenGui");
        B.Name = "AutoGhost_Final_AnimFix";
        B.ResetOnSpawn = false;
        o = r24;
        B.Parent = o.WaitForChild(o, "PlayerGui");
        r28 = Instance.new("TextButton");
        r28.Size = UDim2.new(0, 80, 0, 80);
        r28.Position = UDim2.new(0, 30, 0.5, -120);
        r28.BackgroundColor3 = Color3.fromRGB(0, 120, 215);
        r28.Text = "OFF";
        r28.TextColor3 = Color3.new(1, 1, 1);
        r28.Font = Enum.Font.GothamBold;
        r28.TextSize = 20;
        r28.Parent = B;
        Instance.new("UICorner", r28).CornerRadius = UDim.new(1, 0);
        r29 = Instance.new("TextBox");
        r29.Size = UDim2.new(0, 80, 0, 30);
        r29.Position = UDim2.new(0, 30, 0.5, -30);
        r29.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
        r29.Text = "5";
        r29.PlaceholderText = "Desync Time";
        r29.TextColor3 = Color3.new(1, 1, 1);
        r29.Font = Enum.Font.Gotham;
        r29.Parent = B;
        Instance.new("UICorner", r29);
        r30 = Instance.new("TextButton");
        r30.Size = UDim2.new(0, 80, 0, 40);
        r30.Position = UDim2.new(0, 30, 0.5, 10);
        r30.BackgroundColor3 = Color3.fromRGB(150, 0, 0);
        r30.Text = "AUTO OFF";
        r30.TextColor3 = Color3.new(1, 1, 1);
        r30.Font = Enum.Font.GothamBold;
        r30.Parent = B;
        Instance.new("UICorner", r30);
        r31 = false;
        r32 = false;
        r35 = {};
        r36 = {};
        local function r37(arg1_2, arg2_2, arg3_2, ...)
            r = arg3_2;
            v1 = arg1_2;
            M = v1.FindFirstChild(v1, "Animate");
            if M then
                q = M.FindFirstChild(M, arg2_2);
                if q then
                    v2 = q.FindFirstChild(q, arg3_2) or q.FindFirstChildOfClass(q, "Animation");
                    if v2 then
                        return v2.AnimationId;
                    end;
                end;
            end;
            return nil; 
        end;
        local function r38(...)
            r = r36;
            t = 29[3];
            r = 29[1];
            for t, q in r, pairs(r) do
                if q then
                    q.Stop(q, .1);
                end; 
            end;
            return; 
        end;
        local function r39(...)
            if not r31 then
                return;
            end;
            r31 = false;
            r28.Text = "OFF";
            r28.BackgroundColor3 = Color3.fromRGB(0, 120, 215);
            t = 120[2];
            v1 = 120[1];
            for r, q in pairs(r35) do
                M = r;
                q.Disconnect(q); 
            end;
            r35 = {};
            r38();
            r36 = {};
            if r34 then
                r = r34;
                r.Destroy(r);
            end;
            v2 = r33;
            if v2 then
                v2 = r33;
                M = v2.FindFirstChild(v2, "HumanoidRootPart");
            end;
            v3 = false;
            if v2 then
                r33.HumanoidRootPart.Anchored = false;
                if r34 and 215.FindFirstChild(215, "HumanoidRootPart") then
                    r33.HumanoidRootPart.CFrame = r34 and 215.FindFirstChild(215, "HumanoidRootPart");
                end;
                r24.Character = r33;
                v2 = r33;
                r27.CameraSubject = v2.FindFirstChild(v2, "Humanoid");
            end;
            return; 
        end;
        local function r40(...)
            v3 = r24.Character;
            r33 = v3;
            r = r33;
            v3 = v3;
            if not r or not r.FindFirstChild(r, "HumanoidRootPart") then
                return;
            end;
            r31 = true;
            r28.Text = "ON";
            r28.BackgroundColor3 = Color3.fromRGB(0, 200, 255);
            r33.HumanoidRootPart.Anchored = true;
            r33.Archivable = true;
            v1 = r33;
            r34 = v1.Clone(v1);
            r34.Name = "LD_Ghost_Clone";
            r34.Parent = workspace;
            v2 = r34;
            q = v2[3];
            M = v2[2];
            for q, v2 in pairs(v2.GetDescendants(v2)) do
                v1 = q;
                v3 = v3;
                if v2.IsA(v2, "LocalScript") or v2.IsA(v2, "Script") then
                    v2.Destroy(v2);
                end; 
            end;
            v2 = r34;
            q = v2[3];
            for q, v2 in v2[1], pairs(v2.GetDescendants(v2)) do
                v1 = q;
                if v2.IsA(v2, "BasePart") then
                    v2.Anchored = false;
                    v2.CanCollide = v2.Name == "HumanoidRootPart";
                    F = r15(")\x01\xf5\xda\xcbN\xd6_\x957B\x04\xcde\x88\xd7", 6125035539236);
                    if v2.Name == r16[F] then
                        v2.Transparency = 1;
                        F = v2.GetChildren;
                        l = {
                            F(v2)
                        };
                        o = F[3];
                        for o, l in F[1], pairs(w(l)) do
                            Y = o;
                            v3 = v3;
                            if l.IsA(l, "Decal") or l.IsA(l, "Texture") then
                                l.Destroy(l);
                            end; 
                        end;
                    end;
                end; 
            end;
            v1 = r34;
            r41 = v1.FindFirstChild(v1, "Humanoid");
            r = r34;
            r42 = r.FindFirstChild(r, "HumanoidRootPart");
            if r41 then
                r41.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                q = r36;
                local function M(arg1_3, ...)
                    v1 = arg1_3;
                    if not v1 then
                        return nil;
                    end;
                    t = Instance.new("Animation");
                    t.AnimationId = v1;
                    v3 = r41;
                    return v3.LoadAnimation(v3, t); 
                end;
                v2 = "Run";
                B = v3;
                l = r37(r33, "run", "RunAnim");
                v4 = l;
                if l then
                end;
            end; 
        end;
        local function r43(...)
            v3 = r32;
            while v3 do
                if not r31 then
                    r40();
                end;
                M = 0 < (tonumber(r29.Text) or 5);
                Z = M;
                r = r32;
                while not M do
                    v3 = v3;
                    if Z then
                        task.wait(.1);
                        t = 0 + .1;
                    end;
                    if r32 then
                        r39();
                        task.wait(1);
                    end; 
                end;
                Z = r32; 
            end;
            return; 
        end;
        y = r30.MouseButton1Click;
        y.Connect(y, function(...)
            r32 = not r32;
            if r32 then
                r30.Text = "AUTO ON";
                r30.BackgroundColor3 = Color3.fromRGB(0, 180, 0);
                task.spawn(r43);
            else
                r30.Text = "AUTO OFF";
                r30.BackgroundColor3 = Color3.fromRGB(150, 0, 0);
                r39();
            end;
            return; 
        end);
        y = r28.MouseButton1Click;
        y.Connect(y, function(...)
            if r31 then
                r39();
            else
                r40();
            end;
            return; 
        end);
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