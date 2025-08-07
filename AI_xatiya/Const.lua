---------------------------------------------------	
--ActorData Constants
TARGET_ALLIANCE =1
TARGET_TYPE 	=2
TARGET_LMOTION	=3
TARGET_LASTX 	=4
TARGET_LASTY 	=5
TARGET_STATUS	=6
TARGET_TIMER	=7


-------------- TARGET_ALLIANCE
NEUTRAL		=0	--some targets will be reset to neutral
IGNORE		=1	--always ignore
PASSIVE		=2	--only enemize on owner/target aggression
--SUMMON		=3
OWNER		=4 --most important
HOMUNCULUS	=5 --cant target with status recovery stuff :(
MERCENARY	=6
OWNERSTATUS	=7 --attempt to detect status and use recovery on owner
--OWNERSTATUS2	=8
ALLYSTATUS	=9 --values between this and ownerstatus will try to status recovery
ALLYPROTECT	=10 --between this and owner will try to defend
ALLYALWAYS	=11
ALLY		=12 -- least important. AI can detect if someone of this but not above allies turn against you.

ENEMY		=20 --least important...
ENEMYALWAYS	=22
ENEMYPRIORITY	=40

--note that you can give an enemy (like a guild leader) an absurdly high value, so long as it is above the 20 for ENEMY.
--setting someone in actor presets like so will recognize the target as an enemy and always attack them first.

-------------- TARGET_TYPE. 

LOWESTPRIORITYTARGET = -30 -- gtb user n shit
LOWPRIORITYTARGET = -15	-- supertanks
NONE		=0  	-- unknown type
IGNORETARGET	=1  	-- forced to ignore 
SUPPORTTARGET	=2	-- does ANY CAST TIME spells on ALLY. hard to kill
MVPTARGET	=3	-- mvp. hard to kill!
BOSSTARGET	=4	-- boss. hard to kill!
PLANTTARGET	=5  	-- PLANTS. ally by default, but changed to hostile if aggression is made
KITETARGET	=6  	-- keep your distance!
HIGHFLEETARGET	=7  	-- use +hit or never miss skills?
QUICKENTARGET	=8  	-- uses quicken skills. LK or such.
QUICKEN2TARGET	=9	-- smith, quicken user with support cast.
SUPPORT2TARGET	=10	-- higher priority version of support. squishier supporters
--RECOVERYTARGET	=11 	-- status recovery them
CASTERTARGET	=12	-- spell casters. use silence, highly vulnerable
HOMUNCULUSTARGET=14	-- enemy homunculus
MERCENARYTARGET	=15	-- enemy mercenary
PASSIVETARGET	=16	-- do not aggro unless there is aggression
SUMMONTARGET	=17 	--these are ignored unless they target you/ you target them
TANKTARGET	=19	-- hit once and ignore
PRIORITYTARGET	=25     -- aim for this first..!!
TANKKITETARGET	=27	-- atk and run away from
EMPBREAKTARGET	=28	-- usually sinx only. people who break emp to target with SBR44.
SUPPORT3TARGET	=75	-- highest priority, champions want to asura you...
SQUISHTARGET	=90	-- one hit kills

PROVOKETARGET	=98	-- provoke on "enemies" with the purpose of buffing them
DLPTARGET	=99	-- animation cancelling for mindbreaker's pet
NOSKILLTARGET	=100	-- no skills used
--101 is 1 skill used. 103 is 3 skills used. this feature is meant for say, using moonlight on a target only once and normal attacking to finish it off
--don't set players to values above squishtarget.


------------------------------ TARGET_STATUS
NONE		=0
IGNORE		=1
ENEMYCHECK	=2
FROZEN		=3
SILENCED	=4
TARGETED	=5
IMMOBILIZED	=6
SLOWED		=7
CLOAKED		=8
CLOAKER		=9

-----------------------------BuffTimers
DEFENSETIMER	=1
OFFENSETIMER	=2


-----------results of ActorType(id) function. based on actorid #
PLAYER 	= 1
NPC 	= 2
PORTAL	= 3


--------------------------------------------
-- Returned by GetV(V_HOMUNTYPE) and * -1. GetV(V_MERTYPE) values are modified.
--------------------------------------------
-- some values are shared by players, so AI will adjust hom/mercenary types to negative numbers.
LIF			= -1
AMISTR			= -2
FILIR			= -3
VANILMIRTH		= -4
--					First four are used by HomunClass.
LIF2			= -5
AMISTR2			= -6
FILIR2			= -7
VANILMIRTH2		= -8
LIF_H			= -9
AMISTR_H		= -10
FILIR_H			= -11
VANILMIRTH_H		= -12
LIF_H2			= -13
AMISTR_H2		= -14
FILIR_H2		= -15
VANILMIRTH_H2		= -16
-----					 GetV(V_MERTYPE) values + 16
MARCHER01		= -17
MARCHER02		= -18
MARCHER03		= -19
MARCHER04		= -20
MARCHER05		= -21
MARCHER06		= -22
MARCHER07		= -23
MARCHER08		= -24
MARCHER09		= -25
MARCHER10		= -26
MLANCER01		= -27
MLANCER02		= -28
MLANCER03		= -29
MLANCER04		= -30
MLANCER05		= -31
MLANCER06		= -32
MLANCER07		= -33
MLANCER08		= -34
MLANCER09		= -35
MLANCER10		= -36
MSWORDMAN01		= -37
MSWORDMAN02		= -38
MSWORDMAN03		= -39
MSWORDMAN04		= -40
MSWORDMAN05		= -41
MSWORDMAN06		= -42
MSWORDMAN07		= -43
MSWORDMAN08		= -44
MSWORDMAN09		= -45
MSWORDMAN10		= -46
----					calculated by maxhp/sp
MWILDROSE		= -101
MDOPPLE			= -102
MALICE			= -103

--					PLAYER CLASSES
-- 					discerns players from homun/monster/merc by actor id #
NOVICE		= 0
SWORDSMAN 	= 1
MAGE	 	= 2
ARCHER 		= 3
ACOYLTE 	= 4
MERCHANT 	= 5
THIEF 		= 6
KNIGHT 		= 7
PRIEST 		= 8
WIZARD 		= 9 
BLACKSMITH 	= 10
HUNTER 		= 11
ASSASSIN 	= 12

CRUSADER 	= 14
MONK 		= 15
SAGE 		= 16
ROGUE 		= 17
ALCHEMIST 	= 18
BARD 		= 19
DANCER 		= 20

SUPERNOVICE 	= 23
GUNSLINGER 	= 24
NINJA 		= 25

NOVICE_HIGH 	= 4001
SWORDSMAN_HIGH 	= 4002
NAGE_HIGH 	= 4003
ARCHER_HIGH 	= 4004
ACOLYTE_HIGH 	= 4005
MERCHANT_HIGH 	= 4006
THIEF_HIGH 	= 4007
LORD_KNIGHT 	= 4008
HIGH_PRIEST 	= 4009
HIGH_WIZARD 	= 4010
WHITESMITH 	= 4011
SNIPER 		= 4012
ASSASSIN_CROSS 	= 4013

PALADIN 	= 4015
CHAMPION 	= 4016
PROFESSOR 	= 4017
STALKER 	= 4018
CREATOR 	= 4019
CLOWN 		= 4020
GYPSY 		= 4021

BABY_NOVICE 	= 4023
BABY_SWORDSMAN 	= 4024
BABY_MAGE 	= 4025
BABY_ARCHER 	= 4026
BABY_ACOLYTE 	= 4027
BABY_MERCHANT 	= 4028
BABY_THIEF 	= 4029
BABY_KNIGHT 	= 4030
BABY_PRIEST 	= 4031
BABY_WIZARD 	= 4032
BABY_BLACKSMITH = 4033
BABY_HUNTER 	= 4034
BABY_ASSASSIN 	= 4035		--OMG HIDE THE CHILDREN

BABY_CRUSADER 	= 4037
BABY_MONK 	= 4038
BABY_SAGE 	= 4039
BABY_ROGUE 	= 4040
BABY_ALCHEMIST 	= 4041
BABY_BARD 	= 4042
BABY_DANCER 	= 4043

SUPER_BABY 	= 4045
TAEKWON_KID 	= 4046
TAEKWON_MASTER 	= 4047
SOUL_LINKER 	= 4048



--------------------------------------------------------------------------------------------------------
----Directions. when distance is equal, this is the order of priority in the equation (4 cardinals only)
-------------------------------------------------------------------------------------------------------
WEST		= 1
EAST		= 2
NORTH		= 3
SOUTH		= 4

NORTHWEST	= 5
NORTHEAST	= 6
SOUTHEAST	= 7
SOUTHWEST	= 8




--------------------------Pathoth's Detailed motion list.
--still do not know motions 14,15,29, and 42+  . if you know what these are, please contact me.
--ARG can't even detect sonic blow, cart boost, or stun/freeze/stone/silence? LAME
--some motions can be used to assume enemy class, but none of the important ones.
MOTION_STAND = 0 	-- Standing still
MOTION_MOVE = 1 	-- Moving
MOTION_ATTACK = 2 	-- Attacking
MOTION_DEAD = 3 	-- Laying dead
MOTION_DAMAGE = 4 	-- Taking damage
MOTION_BENDDOWN = 5 	-- Pick up item, set trap
MOTION_SIT = 6 		-- Sitting down
MOTION_SKILL = 7 	-- Used a skill
MOTION_CASTING = 8 	-- Casting a skill
MOTION_VULCAN = 9 	-- Arrow Vulcan, Shadow Slash
MOTION_SLEEP = 10	-- Sleep status (only sleep status is detected? ....)
MOTION_SPIRAL = 11	-- spiral pierce
MOTION_TOSS = 12	-- throw stone, sand attack, venom knife, sheild charge (NOT BOOMERANG!), sheild chain, summon flora, potion pitcher, demonstration, acid terror, ?spear boomerang?
MOTION_COUNTER = 13 	-- Counter-attack
--??
--??
MOTION_DANCE = 16	-- dancer dances, duets
MOTION_SING = 17 	-- bard songs only. no frost joke
MOTION_SHARPSHOOT = 18	-- sharpshooting
MOTION_JUMP_UP = 19 	-- TaeKwon Kid Leap -- rising
MOTION_JUMP_FALL= 20 	-- TaeKwon Kid Leap -- falling
MOTION_PWHIRL = 21	-- TeaKwon prepare whirlwind kick stance
MOTION_PAXE = 22	-- TeaKwon prepare axe kick stance
MOTION_SOULLINK = 23	-- TeaKwon prepare round kick stance, ??Soul Link??
MOTION_PCOUNTER = 24	-- TeaKwon prepare counter kick stance
MOTION_TUMBLE = 25	-- Tumbling / TK Kid Leap Landing
MOTION_COUNTERK = 26	-- TeaKwon counter kick
MOTION_FLYK = 27	-- TeaKwon flying kick
MOTION_BIGTOSS = 28 	-- A heavier toss (slim potions / acid demonstration) 
--??
MOTION_WHIRLK = 30	-- TeaKwon whirlwind kick
MOTION_AXEK = 31	-- TeaKwon axe kick
MOTION_ROUNDK = 32	-- TeaKwon roundhouse kick
MOTION_COMFORT = 33	-- comfort of sun/moon/star
MOTION_HEAT = 34	-- heat activation? not flame dmg
MOTION_NINJAGROUND = 35	-- ninja illusionary shadow, water escape, mist slash, dragon fire formation, crimson fire formation, ice spear, (ninja puts hand on ground)
MOTION_NINJAHAND = 36	-- ninja throw kunai, shuriken, cicada, throw zeny, soul, (ninja says "talk to the hand")
MOTION_NINJACAST = 37	-- ninja casting a spell. ninjas are too good for the normal cast motion
MOTION_GUNTWIN = 38	-- gunslinger shows off his twin guns? flip coin, inc accuracy.. gatling fever, desperado,
MOTION_GUNFLIP = 39	-- gunslinger flips out... a coin?
MOTION_GUNSHOW = 40	-- gunslinger shows the big gun. cracker, gunslinger mine... ?fullbuster?
MOTION_GUNCAST = 41	-- gunslinger casts a spell






---------------------------------------------------------------  Gravity code below
---------------------------------------------------------------
--[[
function	TraceAI (string) end
function	MoveToOwner (id) end
function 	Move (id,x,y) end
function	Attack (id,id) end
function 	GetV (V_,id) end
function	GetActors () end
function	GetTick () end
function	GetMsg (id) end
function	GetResMsg (id) end
function	SkillObject (id,level,skill,target) end
function	SkillGround (id,level,skill,x,y) end
function	IsMonster (id) end								-- idｴﾂ ｸｺﾅﾍﾀﾎｰ｡? yes -> 1 no -> 0

--]]


--------------------------
-- command  
--------------------------
NONE_CMD			= 0
MOVE_CMD			= 1
STOP_CMD			= 2
ATTACK_OBJECT_CMD	= 3
ATTACK_AREA_CMD		= 4
PATROL_CMD			= 5
HOLD_CMD			= 6
SKILL_OBJECT_CMD	= 7
SKILL_AREA_CMD		= 8
FOLLOW_CMD			= 9
--------------------------


-------------------------------------------------
-- constants
-------------------------------------------------


--------------------------------
V_OWNER				=	0		-- ﾁﾖﾀﾎﾀﾇ ID			
V_POSITION			=	1		-- ｹｰﾃｼﾀﾇ ﾀｧﾄ｡ 
V_TYPE				=	2		-- ｹﾌｱｸﾇ・
V_MOTION			=	3		-- ｵｿﾀﾛ 
V_ATTACKRANGE			=	4		-- ｹｰｸｮ ｰﾝ ｹ・ｧ 
V_TARGET			=   	5		-- ｰﾝ, ｽｺﾅｳ ｻ鄙・ｸ･ｹｰ ID 
V_SKILLATTACKRANGE		=	6		-- ｽｺﾅｳ ｻ鄙・ｹ・ｧ 
V_HOMUNTYPE			=   	7		-- ﾈ｣ｹｮﾅｬｷ鄂ｺ ﾁｾｷ・
V_HP				=	8		-- HP (ﾈ｣ｹｮﾅｬｷ鄂ｺｿﾍ ﾁﾖﾀﾎｿ｡ｰﾔｸｸ ﾀ釤・
V_SP				=	9		-- SP (ﾈ｣ｹｮﾅｬｷ鄂ｺｿﾍ ﾁﾖﾀﾎｿ｡ｰﾔｸｸ ﾀ釤・
V_MAXHP				=   	10		-- ﾃﾖｴ・HP (ﾈ｣ｹｮﾅｬｷ鄂ｺｿﾍ ﾁﾖﾀﾎｿ｡ｰﾔｸｸ ﾀ釤・
V_MAXSP				=  	11		-- ﾃﾖｴ・SP (ﾈ｣ｹｮﾅｬｷ鄂ｺｿﾍ ﾁﾖﾀﾎｿ｡ｰﾔｸｸ ﾀ釤・
V_MERTYPE			= 	12

---------------------------------
