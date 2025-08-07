dofile("./AI_xatiya/Const.lua")
local Config = dofile("./AI_xatiya/Default.lua")
dofile("./AI_xatiya/MerConfigBasic.txt")
dofile("./AI_xatiya/Timeout.txt")
dofile("./AI_xatiya/SkillList.lua")
dofile("./AI_xatiya/Util.lua")					
dofile("./AI_xatiya/Actor_Presets.txt")
dofile("./AI_xatiya/RunOnce.lua")
dofile("./AI_xatiya/ActorList.txt")
dofile("./AI_xatiya/Control.lua")

-- Forzar ciclo de IA autónomo para Mercenary (igual que Homunculus)
if not _G.__MERCENARY_AI_LOOP_STARTED then
    _G.__MERCENARY_AI_LOOP_STARTED = true
    local function mercenary_ai_loop()
        if type(AI) == "function" and MyID then
            pcall(function() AI(MyID) end)
        end
        -- Ejecutar cada 200 ms
        if type(package) == "table" and package.loaded and package.loaded["socket"] then
            package.loaded["socket"].sleep(0.2)
        else
            -- fallback para entornos sin socket
            local t0 = os.clock()
            while os.clock() - t0 < 0.2 do end
        end
        mercenary_ai_loop()
    end
    -- Inicializar MyID si es necesario
    if not MyID and type(GetV) == "function" and type(GetActors) == "function" then
        local actors = GetActors()
        for _, id in ipairs(actors) do
            if GetV(V_MERTYPE, id) then
                MyID = id
                break
            end
        end
    end
    mercenary_ai_loop()
end