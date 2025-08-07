--if you know what is good for you, don't mess with this file..!

--YES           = 1
--NO            = 0

local config = {
  state = {
    MercBuff1 = 0,
    MercBuff2 = 0,
    HomunBuff1 = 0,
    HomunBuff2 = 0,
    HomunAware = 0, -- is this phased out?
    HomunCycleLast = 0, -- is this phased out?
    errored = 1,
    MercenaryTarget = 0,
    HomunculusTarget = 0,
    OwnerTarget = 0,
    PatrolCounter = 0,
    PatrolX = 0,
    PatrolY = 0,
    ChaseDistance = 0,
    KiteMoveSwitch = 0,
    KiteTarget = 0,
    Singer = 0,
    OneTimeCheck = 1,
    HomunClass = 0,
    CastTargetLast = 0,
    DmgCheckTarget = 0,
    Dt = {},
    MyHomunculus = 0,
    RecoveryTarget = 0,
    DecloakTarget = 0,
    DecloakX = 0,
    DecloakY = 0,
    Trap1X = 0,
    Trap1Y = 0,
    Trap2X = 0,
    Trap2Y = 0,
    Trap3X = 0,
    Trap3Y = 0,
    TrapTarget = 0,
    Buff1 = 0,
    Buff2 = 0,
    JustSkilled = 0,
    ChaseX = 0,
    ChaseY = 0,
    ChaseTarget = 0,
    DmgCheckTarget2 = 0,
    MyDirection = 1,
    MyMercenary = 0,
    MercX = 0,
    MercY = 0,
    HomunX = 0,
    HomunY = 0,
    BuffTimers = {},
    TrapLevel2 = 0,
    TrapCell = 1,
    Monsters = {},
    VanExThreshold = 7,
  },

  skills = {
    LimitBreak = 0,
    QuickenSkill = 0,
    DevoLevel = 0,
    ProvLevel = 0,
    TrapSkill = 0,
    AOESkill = 0,
    AtkSkill = 0,
    RecoverySkill = 0,
    DecAgiLevel = 0,
    PushBackSkill = 0,
    DecloakSkill = 0,
    DefenseSkill = 0,
    BerserkSkill = 0,
    CrashLevel = 0,
    RescueSkill = 0,
    AtkSkillSp = 0,
    MoveSkill = 0,
  },

  timers = {
    MySpawnTime = GetTick(),
    DanceTimer = 0,
    SongTimer = 0,
    SkillDelayTimer = 0,
    MiscTimer = 0,
    Trap1Delay = 0,
    Trap2Delay = 0,
    Trap3Delay = 0,
    AntiStuckTimer = 0,
    StandbyTick = 0,
    RecoveryTimer = 3000,
    SpawnWait = 0, --3000
    AFKMaxTime = 75, -- minutes
    MiscWait = 15, -- seconds
  },

  priorities = {
    DmgCheckPriority = 0,
    DmgCheckPriority2 = 0,
    ChasePriority = 0,
    OwnerPriority = 10,
    MercPriority = 20,
    HomunPriority = 7,
    FriendPriority = 5,
    AggroHP = 75,
    AggroSP = 80,
  },

  settings = {
    NpcActorNumber = 110000000, -- if actorid is less than this, is a player

    --choose a skill level for homunculus skills. if 0, or you don't have the skill, the skill will be disabled.
    LifAvoidLvl = 5,     -- Urgent escape // emergency avoid
    LifHealLvl = 1,      -- Touch of Heal // Healing Hands
    LifChangeLvl = 1,    -- Mental Change
    FilirMoveLvl = 1,    -- Fleet Move // Flitting
    FilirMoonLvl = 1,    -- Moonlight
    FilirFlightLvl = 1,  -- Accelerated Flight // Overspeed
    AmistrDefLvl = 1,    -- Defense // Amistr Bulwark
    AmistrCstLvl = 1,    -- Castling
    AmistrBloodLvl = 1,  -- Blood Lust
    VanCapriceLvl = 5,   -- Caprice

    UseDefenseSkill = 1,
    UseQuicken = 1,
    UseBerserk = 1,      -- autoberserk on some mercenaries, and frenzy on lvl 10 fencer
    VanUseChaotic = 1,   -- Chaotic Benediction lvl chosen automatically
    LifAlwaysSpeed = 1,  -- lif always uses urgent escape
    LifAlwaysMental = 1, -- lif always uses mental change
    UseLimitBreak = 1,   -- not yet working
    UseDevotion = 1,     -- attempt to automatically use Mercenary Devotion on owner

    AttemptDecloak = 1,  -- attempt to decloak enemies within range
    UseProvoke = 1,
    UsePushback = 0,
    PushbackDistance = 2,
    UseTraps = 1,

    UseDivina = 1,
    UseDecAgi = 1,

    UseRecovery = 0,     -- use status recovery skills at all?
    UseTimerRecovery = 1,
    SRecoveryOwner = 1,

    UseAOESkills = 1,
    AOEMinMobCount = 2,
    UseAtkSkills = 1,
    UseDefender = 1,

    UseCrash = 1,
    UseMagni = 0,
    UseRescueSkill = 1,
    RescueHpPercent = 50,

    FollowChaseDown = 1,
    MoveChaseDown = 0,
    AIDecideChase = 1,

    MaxDistance = 17,
    FollowDistance = 1,
    FollowMax = 11,
    MoveRadius = 5,
    IdleDistance = 1,

    ISupportCast = 1,
    ManAtkAlliance = IGNORE,
    ManAtkType = IGNORETARGET,
    ManSkillAlliance = ENEMY,
    ManSkillType = PRIORITYTARGET,

    SuperAggro = 1,
    SuperPassive = 0,

    WriteActorInfo = 0,

    TrapFollowForm = 0,
    TrapFollowSP = 80,
    TrapMoveForm = 0,
    TrapMoveSP = 30,

    MoveToSingers = 1,
    KiteHostiles = 1,
    KiteAllEnemies = 0,
    KiteDistance = 4,

    PatrolDistance = 1,
    PatrolType = 2,

    ProvokeOwner = 0,
  },
}

-- expose config values as globals for backward compatibility
for _, group in pairs(config) do
  if type(group) == "table" then
    for key, value in pairs(group) do
      _G[key] = value
    end
  end
end

return config

