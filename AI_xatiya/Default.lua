
--if you know what is good for you, don't mess with this file..!

--YES		= 1
--NO		= 0
MercBuff1	= 0
MercBuff2	= 0
HomunBuff1	= 0
HomunBuff2	= 0
HomunAware	= 0 	-- is this phased out?
HomunCycleLast	= 0	-- is this phased out?
errored		= 1
MercenaryTarget	= 0
HomunculusTarget = 0
OwnerTarget	= 0
PatrolCounter	= 0
PatrolX		= 0
PatrolY 	= 0
MySpawnTime	= GetTick()
ChaseDistance	= 0
KiteMoveSwitch	= 0
KiteTarget 	= 0
Singer		= 0
DanceTimer	= 0
SongTimer	= 0
--NearbySong 	= 0
SkillDelayTimer = 0
OneTimeCheck 	= 1
--OwnerType	= 0
--IAmHomunculus	= 0
--ActorDataClean= 0
HomunClass	= 0
LimitBreak	= 0
QuickenSkill	= 0
DevoLevel	= 0
ProvLevel	= 0
LimitBreak	= 0
TrapSkill	= 0
AOESkill	= 0
AtkSkill	= 0
RecoverySkill	= 0
DecAgiLevel	= 0
PushBackSkill	= 0
DecloakSkill	= 0
DefenseSkill	= 0
BerserkSkill	= 0
CrashLevel	= 0
RescueSkill	= 0
--OwnerMotionLast = 0
CastTargetLast	= 0
--DmgCheckTimeout = 0
DmgCheckTarget	= 0
--SuccessTest 	= 0
--OwnerStatusTimer= 0
--Statused 	= {}
Dt	= {}
MyHomunculus	= 0
--Timeout		= {}	
MiscTimer	= 0
--MyEnemy2	= 0
--RecoveryAlliance= 0
--vPreset		= 0
--UpdateCycle	= 0
--UsedSkill	= 0
RecoveryTarget	= 0
DecloakTarget	= 0
DecloakX	= 0
DecloakY	= 0
--LastEnemyCount	= 0
Trap1Delay,Trap2Delay,Trap3Delay		= 0,0,0
Trap1X,Trap1Y,Trap2X,Trap2Y,Trap3X,Trap3Y	= 0,0,0,0,0,0
PushbackSkill	= 0
TrapSkill	= 0
DecAgiLevel	= 0
DecloakSkill	= 0
TrapTarget	= 0
--LastSleepTarget	= 0
--vPriorityOld	= 0
--vOld		= 0
LimitBreak	= 0
--ZerkQuicken	= 0
--JustBuffed	= 0
Buff1,Buff2	= 0,0
--AutoZerkOn	= 0
JustSkilled	= 0
--HomunCycleLast	= 0
ChaseX,ChaseY,ChaseTarget = 0,0,0
--LastState	=0
--DmgCheckCaprice = 0
AntiStuckTimer = 0

AtkSkillSp	= 0
--DmgCheckList	= {}
DmgCheckTarget = 0
DmgCheckTarget2 = 0
--DmgCheckTimeout2 = 0
DmgCheckPriority = 0
DmgCheckPriority2 = 0
ChaseTarget	=0
ChasePriority = 0
--ChaseCheckList = {}
--Chasing = 0
--MercID=0
--HomunID=0
StandbyTick=0
MyDirection=1
ChaseWait = 0
MyHomunculus = 0
MyMercenary = 0
MercX,MercY,HomunX,HomunY = 0,0,0,0
BuffTimers = {}
--NewSummon = 0
TrapLevel2 = 0
TrapCell = 1
Monsters = {}
HomunculusTarget = 0
MercenaryTarget = 0
OwnerTarget = 0
VanExThreshold 	= 7
MoveSkill = 0

------------------------ if actorid is less than this, is a player
NpcActorNumber 	= 110000000
--if actorid is more than this, is probably not a portal
--PortalLimit 	= 110003100
--if actorid is more than this, is probably not an npc/flag/unkillable monster
--NpcActorLimit	= 110013000
-- time in.. miliseconds? how long motions don't change before it assumes you are statused.

-----------------------configurables
--for most values in this file, yes = 1, no = 0. the rest will specify that other numbers can be used.
--choose a skill level for homunculus skills. if 0, or you don't have the skill, the skill will be disabled. 
LifAvoidLvl	= 5	--Urgent escape // emergency avoid
LifHealLvl	= 1	--Touch of Heal // Healing Hands. this will be impossible to use if stuck in mental change or emergency avoid delays.
LifChangeLvl	= 1	--Mental Change
FilirMoveLvl	= 1	--Fleet Move // Flitting
FilirMoonLvl	= 1	--Moonlight
FilirFlightLvl	= 1	--Accelerated Flight // Overspeed
AmistrDefLvl	= 1	--Defense // Amistr Bulwark
AmistrCstLvl	= 1	--Castling
AmistrBloodLvl	= 1	--Blood Lust
VanCapriceLvl	= 5	--Caprice


--"defense" skills are. Defense // Amistr Bulwark, Accelerated Flight // Overspeed, parrying, autoguard, reflect shield, Mental Change(good offense is good defense heh)
--because lif skill deleays interfere with each other, mental change will only be used if nearby song is detected. 
--song detection is not perfect, if the bard moves while singing, AI will no longer detect a song.
--mental change will only be used if enemy is detected
UseDefenseSkill = 1
--Lif Urgent Escape, Filir Fleet Move, Mercenary 2 hand quicken, Amistr BloodLust(bloodlust will only be used if an enemy is detected
--urgent escape will only be used near a bard song unless LifAlwaysSpeed  = true
UseQuicken	= 1	--Lif Urgent Escape, Filir Fleet Move, Mercenary 2 hand quicken, Amistr BloodLust(bloodlust will only activate with onscreen enemies)	
UseBerserk	= 1	--autoberserk on some mercenaries, and frenzy on lvl 10 fencer(why would you waste points on lvl 10?)
VanUseChaotic	= 1	--Chaotic Benediction lvl is chosen automatically, based on remaining hp of Owner/Homunculus
LifAlwaysSpeed  = 1	--if enabled, lif will always use urgent escape. due to skill delays, this will make it impossible to use mental change without bragi.
LifAlwaysMental	= 1	--if enabled, lif will always use mental change. note that avoid takes priority, and this won't do anything if stuck in avoid delay.
UseLimitBreak 	= 1	--not yet working. meant for calculated use of SBR44 and Bio Explosion
UseDevotion	= 1	--Attempt to automatically use Mercenary Devotion on owner

--Attempt to decloak an enemy who just disappeared within range for cloak, chasewalk, hide. mercenary doesnt know the difference. 
--will not work if enemy cloaks first and then moves within range. skills are: sight, arrowshower, magnumbreak, freezing trap, sandman, landmine.
--also, sight and magnum break will automatically be used on a "move" command. sight immediately, and magnum twice upon reaching destination.
AttemptDecloak	= 1
UseProvoke	= 1	--will use provoke to break casts on CASTERTARGETS and buff Plant summons. use with homunculus and WriteActorInfo to help ID players//monsters

--will attempt to pushback enemies from mercenary based on distance. 
--PushBack skills are: charge arrow, skidtrap, arrow shower, brandish spear, magnum break, bowling bash. to pushback from owner, lower followdistance.
UsePushback	= 0	
PushbackDistance= 2	--if this many cells or closer, try to push enemy away
UseLimitBreak 	= 1	--not yet enabled. for future AI control of SBR44 and Bio Explosion
UseTraps	= 1	--disabling will stop trap use for everything except decloaking



--attempt to use lex divina to silence enemies. mercenary cannot detect silence status, so it will assume it succeeded unless enemy uses a skill
--CasterTargets get priority. if enemy is already silenced by another source, mercenary may end up unsilencing them. 
UseDivina	= 1	
UseDecAgi	= 1	--use decrease agility on enemies. QUICKENTARGET or QUICKEN2TARGET get priority and will have it cast multiple times.



--use Mercenarystatus recovery skills on ALLYSTATUS or OWNERSTATUS alliance targets. will be used once immediately on summoning//AI loading. 
--Benediction, Compress, Recuperate, MentalCure, LexDivina(to cure silence) will also be used when the targets sit down
--Tender,Regain can use timers and estimate if targets are statused or not based on inactivity
--for regain, sleep status is the only status that can be detected by AI and sleep cure will be nearly instantaneous.
UseRecovery	= 0	--use status recovery skills at all?
UseTimerRecovery = 1	--attempt to detect stun, stone curse, freeze status based time between motion changes? if you move or sit, won't cure you
RecoveryTimer	= 3000	--miliseconds before timerrecovery assumes you are statused and tries to cure you
SRecoveryOwner 	= 1	--whether or not to use status recovery skills on owner

--whether or not to use AOE skills at all. arrowshower, brandish spear, bowling bash, magnum break
--AI will automatically choose target. note that only known enemies are accounted for, players or monsters who have not been attacking you 
--or attacked by you or ALLYPROTECT//ALLYSTATUS ally will be ignored. unless a non-support type has been specified, player casts will not specify as an enemy.
--homunculus can help with type detection.
UseAOESkills	= 1	
AOEMinMobCount	= 2	-- the amount of known enemies before using aoe skill.
UseAtkSkills	= 1	--attack skills are caprice, moonlight, doublestrafe, pierce, bash, spiralpierce
UseDefender	= 1	--lvl 9 spear uses lvl 3 when enemies near. lvl 4 spear doesnt use, too many drawbacks to lvl 1 defender.

--"defense" skills are. Defense // Amistr Bulwark, Accelerated Flight // Overspeed, parrying, autoguard, reflect shield, Mental Change(good offense is good defense heh)
--because lif skill deleays interfere with each other, mental change will only be used if nearby song is detected. 
--song detection is not perfect, if the bard moves while singing, AI will no longer detect a song.
UseDefenseSkill = 1	
UseBerserk	= 1	--autoberserk on some mercenaries, and frenzy on lvl 10 fencer(why would you waste points on lvl 10?)
UseCrash	= 1	--not yet enabled. if someone actually wants It I'll code it...
UseMagni	= 0	--will use magnificat on lvl 4 bow mercenary

--Use rescue skills based on remaining Owner HP. rescue skills are Castling, Touch of Heal // Healing Hands, ScapeGoat.
UseRescueSkill	= 1	
RescueHpPercent	= 50	--what Owner HP % is before using rescue skill

FollowChaseDown	= 1	--when in follow mode, chase after enemies?
MoveChaseDown	= 0	--when in move mode, chase after enemies?
AIDecideChase	= 1	--overrides and prevents weaker mercenaries from chasing (lvl 1-6 bow, spear, fencer). 

--how long to wait before taking action on spawning. even if alch is invulnerable, homun is not. don't ever put this above 3000 (3 seconds)
SpawnWait	= 0 --3000
MaxDistance	= 17	--when beyond this distance, drops everything and returns to owner. if above 14, will leave homun/merc offscreen.
--note that kiting overrides the below settings
FollowDistance 	= 1	--follow distance when idle or not chasing
FollowMax	= 11	--maximum distance while in follow mode. also affects chasing down enemies in follow mode
MoveRadius	= 5	--once you tell homun/merc to move, the maximum distance it will move from that point
IdleDistance	= 1	-- if you hit the standby key 3 times, doing anything but sitting, homun will become idle and do nothing except emergency actions. this is the follow distance for idlestate.

--owner uses single target spells on allies, which have a cast time. for mercenary users, the wrong setting will cause AI to incorrectly set allies as enemies
-- examples include agi up, soul exchange, devotion, kaupe. if you use any of these, set to 1.
-- support skills like blessing, aid slim potion, heal, windwalk, safetywall, enchant poison do not count. 
-- this setting makes it so when you cast spells on someone, they do not become enemies. attacking, being attack, throw stone etc still count.
--if you are support type and want a way to set enemies quickly and easily, strongly consider using stapo card/throw stone. 
ISupportCast	= 1

-- any value but "NONE" or "NEUTRAL" will change the alliance or type. for usable values, see Const.lua
-- the below can be used to make an "attack" command tell your pet to ignore the guild mindbreaker, or such.
-- note that setting the incorrect values on a target can cause odd behavior. especially if the mercenary uses cast time spells.
-- on manually attacking a target, (alt + left click on target), set alliance and type as:
ManAtkAlliance	= IGNORE
ManAtkType	= IGNORETARGET 
--manually using a skill will set the target as the following alliance and type except for "NONE" or "NEUTRAL" as above
--recovery skills are the exception, will set alliance to ALLYSTATUS
--if neither is set to IGNORE, will use the skill
ManSkillAlliance= ENEMY
ManSkillType	= PRIORITYTARGET

--priority to attack certain targets, based on distance, who they attack, and who they are attacked by. higher values = higher priority.
-- a value of zero means distance, targeting or being targeted by them has no effect on priority.
OwnerPriority	=15
MercPriority	=10
HomunPriority	=7
FriendPriority	=5	--limited only to whom they are being targeted by. allies, etc

--when no known enemies, try to attack anything it can. useful pvm, this can be good or bad in a crowded pvp room...
SuperAggro	=1
AggroHP		= 75	--% of homun/merc hp before becoming aggressive. will still attack if attacked. set to 0 to always be aggressive
AggroSP		= 80	--% of sp before becoming aggressive
SuperPassive	=0	--totally ignore all enemies. overrides SuperAggro

--will write actor data to ActorList.lua. this is useful for preserving enemy list between deaths, summonings, and sharing data between mercenary/homun
--note that only one client can use this at a time or bad things happen and you will have to erase the contents
--to set a value for an enemy player permanently, place it in Actor_Presets.lua
--to set all players on screen to ally, sit down and press standby 3 times within 5 seconds. this will speed up aggro checks, and enable status cure on sitting
--to erase the contents of the actorlist, sit down and press standby 5 times within 5 seconds. you will get a popup.
WriteActorInfo	=0

--for trapping when idle, TrapForms 1-3 are from compact to spread out. form4 is SS graffiti.
TrapFollowForm	=0	--to be used when following owner
TrapFollowSP	=80	-- % of maxsp before idletrapping
TrapMoveForm	=0	-- to be used after move command. has an additional, direction based form 5.
TrapMoveSP	=30

AFKMaxTime	= 75 -- in minutes. amount of time before an afk popup appears. if you do not click immediately, client will disconnect

MoveToSingers	=1	--if a bard song is being used, move toward the bard every 20 seconds to refresh song. cannot detect what type of song.
KiteHostiles 	=1	--enable kiting. specific monsters, players, and types can be set in Actor_Presets.lua
KiteAllEnemies 	=0	--run away from everything!
KiteDistance 	=4	--kite to this distance before doing anything else. note that kiting ignores followmax, moveradius, but not maxdistance.

MiscWait	= 15	--seconds

PatrolDistance 	= 1 -- distance to patrol around owner when idle. if 0, Patrolling is disabled
PatrolType 	= 2 --1 =box, 2 = diamond. box more practical, diamond more annoying

ProvokeOwner	= 0	--whether or not to attempt to buff owner using provoke. other targets can be set with "PROVOKETARGET" type.
AtkDLP		= 1	--best used with and overrides superpassive, this will atk "DLPTARGET" with the purpose of breaking animation delay