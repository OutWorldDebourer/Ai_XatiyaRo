MyPresets = {
    [1] = {
        Name = "Mavka",
        Type = "MONSTER",
        Alliance = "AGGRESSIVE",
        Priority = 100,
        ForceTarget = 1,       -- Fuerza que sea objetivo
        ForcedTargetOnly = 1,  -- SOLO atacará este objetivo
        IgnoreDamage = 0,      -- No ignora daño de Mavka

        -- Nuevas opciones de configuración
        AttackDistance = 1,    -- Distancia desde la que atacará (células)
        ChaseDistance = 14,     -- Distancia máxima que perseguirá
        KiteMonster = 0,       -- Si debe mantener distancia mientras ataca (0/1)
        UseSkillOnly = 0,      -- Solo usar habilidades, no ataques normales (0/1)
        ChaseSight = 1,        -- Perseguir solo si está en rango visual (0/1)
        AggroOverkill = 0,     -- Seguir atacando después de muerto (0/1)
        StayAway = 2,          -- Mantener esta distancia mínima del mob
        LowHP = 50,            -- % de HP para empezar a kitear
        SkillOnly = {          -- Lista de habilidades específicas a usar
            "CR_HOLYCROSS",
            "LK_JOINTBEAT",
            "CAPRICE"
        }
    },
    [2] = {
        Name = "Baba Yaga",    -- ID: 1882
        Type = "MONSTER",
        Alliance = "NEUTRAL",
        Priority = 0,
        IgnoreDamage = 1,      -- Ignora el daño
        ForcePassive = 1,      -- Fuerza modo pasivo
        StayAway = 5,           -- Mantiene distancia
        LowHP = 100,            -- % de HP para empezar a kitear
    },
    [3] = {
        Name = "Uzhas",        -- ID: 1883
        Type = "MONSTER",
        Alliance = "NEUTRAL",
        Priority = 0,
        IgnoreDamage = 1,
        ForcePassive = 1,
        StayAway = 5,
        LowHP = 100,            -- % de HP para empezar a kitear
    },
    [4] = {
        Name = "Gopinich",     -- ID: 1885
        Type = "MONSTER",
        Alliance = "NEUTRAL",
        Priority = 0,
        IgnoreDamage = 1,
        ForcePassive = 1,
        StayAway = 5,
        LowHP = 100,            -- % de HP para empezar a kitear
    },
    [5] = {
        Name = "ALL_MONSTER",  -- Configuración para el resto de mobs
        Type = "MONSTER",
        Alliance = "NEUTRAL",
        Priority = 0,
        IgnoreDamage = 1,
        LowHP = 100,            -- % de HP para empezar a kitear
    }
}
