--if you don't want a certain mercenary to do something, like say MSWORDMAN01 shouldnt waste sp bashing
--just comment it out.

function MerTypeCheck()
	if (MyMaxHP > 250 and MyMaxHP < 333 and MyMaxSP >= 200 and 250 >= MyMaxSP ) then 
		return 17 --archer01
	elseif (MyMaxHP >= 4000 and 5000 >= MyMaxHP and MyMaxSP >= 50 and MyMaxSP < 65 ) then
		return 101 --wildrose
	elseif (MyMaxHP >= 7200 and 9000 >= MyMaxHP and MyMaxSP >= 200 and MyMaxSP < 250 ) then
		return 102 --dopple
	elseif (MyMaxHP >= 10000 and 13000 >= MyMaxHP and MyMaxSP >= 220 and MyMaxSP < 300 ) then
		return 103 --alice
	else
		TraceAI("Unknown Type")
		return 100 
	end
end

function	GetQuickenSkill()
	local level = 0
	local skill = 0
	local sp = 0
	local duration = 0
	if (HomunClass==LIF) then 
		level=LifAvoidLvl
		skill=HLIF_AVOID
		duration = (40000 - (5000*level))
		sp = 15+5*level
	elseif	(HomunClass==FILIR) then 
		level=FilirMoveLvl
		skill=HFLI_FLEET
		duration = 60000 - (level*5000)
		sp =20+10*level
	elseif (HomunClass == AMISTR) then
		skill=HAMI_BLOODLUST
		level=AmistrBloodLvl
		sp=120
		duration = 60000 +((level -1)* 120000)
	elseif (MyType==MARCHER03) then
		level=1
	elseif (MyType==MARCHER08) then
		level=2
	elseif (MyType==MARCHER10) then
		level=5
	elseif (MyType==MSWORDMAN03) then
		level=1
	elseif (MyType==MSWORDMAN06) then
		level=5
	elseif (MyType==MSWORDMAN08) then
		level=10
	elseif (MyType==MSWORDMAN10) then
		level=10
	elseif (MyType==MLANCER06) then
		level=2
	elseif (MyType==MLANCER10) then
		level=5
	elseif (MyType==MDOPPLE) then
		level=5
	end
	if (level ~= 0) then
		if (HomunClass == 0) then
			skill=MER_QUICKEN 
			sp=10+4*level
			duration = level * 30000
		end
	else
		skill = 0
	end
	TraceAI("Quicken Level: " ..level.. " Skill: " ..skill.. " Sp: " ..sp.. " Duration: " ..duration)
	return skill,level,sp,duration
end

function GetDevotionSkill()
	local level = 0
	local duration = 0
	if (MyType==MLANCER03) then
		level=1
		duration=30000
	elseif (MyType==MLANCER07) then
		level=1
		duration=30000
	elseif (MyType==MLANCER10) then
		level=3
		duration=60000
	elseif (MyType==MDOPPLE) then
		level=3
		duration=60000
	end
	TraceAI("Devo Level: " ..level.. " Duration: " ..duration)
	return level,duration
end

function GetProvokeSkill()
	local level = 0
	local sp = 0
	if (MyType==MARCHER05) then
		level=1
		sp =4
	elseif (MyType==MARCHER08) then
		level=3
		sp=6
	elseif (MyType==MSWORDMAN02) then
		level=5
		sp=8
	elseif (MyType==MLANCER08) then
		level=5
		sp=8
	elseif (MyType==MALICE) then
		level=5
		sp=8
	end
	TraceAI("Provoke Level: " ..level.. " Sp: " ..sp)
	return level,sp
end


--note that because archer 2 and 7 have two different decloak skills, sight and freezetrap are hardcoded to use when in range.
function GetDecloakSkill()
	local skill = 0
	local level = 0
	local sp = 0
	local targetmethod = 0
	if (HomunClass ~= 0) then
		skill=0
	elseif (MyType==MARCHER02) then
		skill=MA_SHOWER
		level=2
		sp=15
		targetmethod = 2
	elseif (MyType==MARCHER07) then
		skill=MA_SHOWER
		level=10
		sp=15
		targetmethod = 2
	elseif (MyType==MLANCER02) then
		skill=ML_BRANDISH
		level=2
		sp=12
		targetmethod = 1
	elseif (MyType==MLANCER06) then
		skill=ML_BRANDISH
		level=5
		sp=12
		targetmethod = 1
	elseif (MyType==MLANCER09) then
		skill=ML_BRANDISH
		level=10
		sp=12
		targetmethod = 1
	elseif (MyType==MSWORDMAN02) then
		skill=MS_MAGNUM
		level=3
		sp=30
		targetmethod = 0
	elseif (MyType==MSWORDMAN04) then
		skill=MS_MAGNUM
		level=5
		sp=30
		targetmethod = 0
	elseif (MyType==MSWORDMAN08) then
		skill=MS_BOWLINGBASH
		level=5
		sp=17
		targetmethod = 1
	elseif (MyType==MSWORDMAN09) then
		skill=MS_BOWLINGBASH
		level=8
		sp=20
		targetmethod = 1
	elseif (MyType==MSWORDMAN10) then
		skill=MS_BOWLINGBASH
		level=10
		sp=22
		targetmethod = 1
	elseif (MyType==MALICE) then
		skill=ML_BRANDISH
		level=5
		sp=12
		targetmethod = 1
	elseif (MyType==MARCHER08) then
		skill=MA_SANDMAN
		level=3			
		sp=12
		targetmethod = 2
	elseif (MyType==MARCHER09) then
		skill=MA_LANDMINE
		level=5
		sp=10
		targetmethod = 2
	elseif (MyType==MARCHER10) then
		skill=MA_SHARPSHOOTING
		level=5
		sp=30
		targetmethod = 1
	end
	TraceAI("DecloakSkill is " ..skill.. " Level: "..level.. " Sp: " ..sp.. " Targetmethod: " ..targetmethod)
	return skill,level,sp,targetmethod
end

function GetLimitBreak()
	if (HomunClass==FILIR) then
		TraceAI("LimitBreaker is SBR44") 
		return HFLI_SBR44
	elseif(HomunClass==VANILMIRTH) then
		TraceAI("LimitBreaker is SELFDESTRUCT") 
		return HVAN_SELFDESTRUCT
	else
		return 0
	end
end

function GetTrapSkill()
	local skill = 0
	local level = 0
	local sp = 0
	if (MyType==MARCHER06) then
		skill=MA_SKIDTRAP
		level=1
		sp =27
	elseif (MyType==MARCHER07) then
		skill=MA_FREEZINGTRAP
		level=3
		sp =10
	elseif (MyType==MARCHER08) then
		skill=MA_SANDMAN
		level=3			
		sp=12
	elseif (MyType==MARCHER09) then
		skill=MA_LANDMINE
		level=5
		sp=10
	end
	TraceAI("TrapSkill is " ..skill.. " Level: "..level.. " Sp: " ..sp)
	return skill,level,sp
end

function GetAOESkill()
	local skill = 0
	local level = 0
	local sp = 0
	local method = 0
	local radius = 0
	local range = 0
	if (HomunClass ~= 0) then
		skill=0
--	elseif (MyType==MARCHER02) then
--		skill=MA_SHOWER
--		level=2
--		sp=15
--		method=2
--		radius = 2	
--		range = 11	
	elseif (MyType==MARCHER07) then
		skill=MA_SHOWER
		level=10
		sp=15
		method=2
		radius = 2
		range = 11
--	elseif (MyType==MLANCER02) then
--		skill=ML_BRANDISH
--		level=2
--		sp=12
--		method=1
--		radius = 2
	elseif (MyType==MLANCER06) then
		skill=ML_BRANDISH
		level=5
		sp=12
		method=1
		radius = 2
		range = 3
	elseif (MyType==MLANCER09) then
		skill=ML_BRANDISH
		level=10
		sp=12
		method=1
		radius = 2
		range = 3
--	elseif (MyType==MSWORDMAN02) then
--		skill=MS_MAGNUM
--		level=3
--		sp=30
--		method=0
--		radius = 2
	elseif (MyType==MSWORDMAN04) then
		skill=MS_MAGNUM
		level=5
		sp=30
		method=0
		radius = 2
	elseif (MyType==MSWORDMAN08) then
		skill=MS_BOWLINGBASH
		level=5
		sp=17
		method=1
		radius = 1
		range = 3
	elseif (MyType==MSWORDMAN09) then
		skill=MS_BOWLINGBASH
		level=8
		sp=20
		method=1
		radius = 1
		range = 3
	elseif (MyType==MSWORDMAN10) then
		skill=MS_BOWLINGBASH
		level=10
		sp=22
		method=1
		radius = 1
		range = 3
	elseif (MyType==MALICE) then
		skill=ML_BRANDISH
		level=5
		sp=12
		method=1
		radius = 2
		range = 3
	end
	TraceAI("AOESkill is " ..skill.. " Level: "..level.. " Sp: " ..sp)
	return skill,level,sp,method,radius,range
end

function GetPushbackSkill()
	local skill = 0
	local level = 0
	local sp = 0
	range = 3
	if (HomunClass ~= 0) then
		skill=0
	elseif (MyType==MARCHER03) then
		skill=MA_CHARGEARROW
		level=1
		sp=15
		range = 10
	elseif (MyType==MARCHER06) then
		skill=MA_SKIDTRAP
		level=3
		sp=15
		range = 4
	elseif (MyType==MARCHER09) then
		skill=MA_CHARGEARROW
		level=1
		sp=15	
		range = 10
	elseif (MyType==MARCHER10) then
		skill=MA_CHARGEARROW
		level=1
		sp=15
		range = 10
	elseif (MyType==MARCHER02) then
		skill=MA_SHOWER
		level=2
		sp=15
	elseif (MyType==MARCHER07) then
		skill=MA_SHOWER
		level=10
		sp=15
	elseif (MyType==MLANCER02) then
		skill=ML_BRANDISH
		level=2
		sp=12
	elseif (MyType==MLANCER06) then
		skill=ML_BRANDISH
		level=5
		sp=12
	elseif (MyType==MLANCER09) then
		skill=ML_BRANDISH
		level=10
		sp=12
	elseif (MyType==MSWORDMAN02) then
		skill=MS_MAGNUM
		level=3
		sp=30
		range=2
	elseif (MyType==MSWORDMAN04) then
		skill=MS_MAGNUM
		level=5
		sp=30
		range=2
	elseif (MyType==MSWORDMAN08) then
		skill=MS_BOWLINGBASH
		level=5
		sp=17
	elseif (MyType==MSWORDMAN09) then
		skill=MS_BOWLINGBASH
		level=8
		sp=20
	elseif (MyType==MSWORDMAN10) then
		skill=MS_BOWLINGBASH
		level=10
		sp=22
	elseif (MyType==MALICE) then
		skill=ML_BRANDISH
		level=5
		sp=12
	end
	TraceAI("PushbackSkill is " ..skill.. " Level: "..level.. " Sp: " ..sp)
	return skill,level,sp,range
end

function GetDequickenSkill()
	--only MER_DECAGI
	local level = 0
	local sp = 0
	if (MyType==MSWORDMAN01) then
		level=1
		sp =27
	elseif (MyType==MSWORDMAN06) then
		level=3
		sp =31
	--elseif (MyType==MARCHER06) then
	--	level=1
	--	sp =27
	end
	TraceAI("DecAgi Level: "..level.. " Sp: " ..sp)
	return level,sp
end

function GetRecoverySkill()
	local skill = 0
	local sp = 0
	if (HomunClass ~= 0) then
		skill=0
	elseif (MyType==MARCHER04) then
		skill=MER_TENDER
		sp = 10
	elseif (MyType==MARCHER05) then
		skill=MA_REMOVETRAP	
		sp = 5
	elseif (MyType==MARCHER07) then
		skill=MER_MENTALCURE
		sp = 10
	elseif (MyType==MSWORDMAN03) then
		skill=MER_BENEDICTION
		sp = 10	
	elseif (MyType==MSWORDMAN05) then
		skill=MER_BENEDICTION
		sp = 10
	elseif (MyType==MSWORDMAN08) then
		skill=MER_COMPRESS
		sp = 10
	elseif (MyType==MLANCER01) then
		skill=MER_REGAIN
		sp = 10
	elseif (MyType==MLANCER02) then
		skill=MER_LEXDIVINA
		sp = 20
	elseif (MyType==MLANCER03) then
		skill=MER_RECUPERATE
		sp = 10
	end
	TraceAI("Recovery skill is "..skill.. " Sp: " ..sp)
	return skill,sp
end

--moonlight range 2, spiral range 6, caprice range 10, others are same as atkrange
function GetAtkSkill()
	local skill = 0
	local level = 0
	local sp = 0
	local range = 3
	local delay = 0
	if (HomunClass == VANILMIRTH) then
		skill=HVAN_CAPRICE
		level=VanCapriceLvl
		sp=(level*2) +20
		range = 10
		delay = 800 + (level * 200)
	elseif (HomunClass == FILIR) then
		skill=HFLI_MOON
		level=FilirMoonLvl
		sp = level * 4
		range = 2   --is it supposed to be higher?
	elseif (MyType==MARCHER01) then
		skill=MA_DOUBLE
		level=2
		sp=12
		range = 11
	elseif (MyType==MARCHER05) then
		skill=MA_DOUBLE
		level=5
		sp=12
		range = 11
	elseif (MyType==MARCHER06) then
		skill=MA_DOUBLE
		level=7
		sp=12
		range = 11
	elseif (MyType==MARCHER09) then
		skill=MA_DOUBLE
		level=10
		sp=12
		range = 11
		--delay = 1000
	elseif (MyType==MLANCER01) then
		skill=ML_PIERCE
		level=1
		sp=9
	elseif (MyType==MLANCER03) then
		skill=ML_PIERCE
		level=2
		sp=9
	elseif (MyType==MLANCER05) then
		skill=ML_PIERCE
		level=5
		sp=9
	elseif (MyType==MLANCER08) then
		skill=ML_PIERCE
		level=10
		sp=9
	elseif (MyType==MLANCER10) then
		skill=ML_SPIRALPIERCE
		level=5
		sp=30
		range = 6
--	elseif (MyType==MSWORDMAN01) then
--		skill=MS_BASH
--		level=1
--		sp=8
	elseif (MyType==MSWORDMAN05) then
		skill=MS_BASH
		level=5
		sp=8
	elseif (MyType==MSWORDMAN07) then
		skill=MS_BASH
		level=10
		sp=15
	elseif (MyType==MSWORDMAN10) then
		skill=MS_BASH
		level=10
		sp=15
	elseif (MyType==MWILDROSE) then
		skill=MS_BASH
		level=5
		sp=8
	elseif (MyType==MDOPPLEMERC) then
		skill=MS_BASH
		level=5
		sp=8
	end
	if (level == 0 ) then
		skill = 0
	end
	TraceAI("Atk skill is "..skill.. " Level: " ..level.. " Range: " ..range.. " Sp: " ..sp)
	return skill,level,range,sp,delay
end

function GetDefenseSkill()
	local skill = 0
	local level = 0
	local sp = 0
	local duration = 0
	if (HomunClass == AMISTR) then
		skill=HAMI_DEFENCE
		level=AmistrDefLvl
		sp=(level*5) +15
		duration = (45 - (level * 5)) * 1000
	elseif (HomunClass==LIF) then 
		level=LifChangeLvl
		skill=HLIF_CHANGE
		sp = 100
		duration = 60000 + ((level -1) * 120000)
	elseif (HomunClass == FILIR) then
		skill=HFLI_SPEED
		level=FilirFlightLvl
		sp = 20 + (level * 10)
		duration = (65 - (level * 5)) * 1000
	elseif (MyType==MSWORDMAN08) then
		skill=MS_PARRYING
		level=4
		sp=50
		duration = 30000
	elseif (MyType==MSWORDMAN09) then
		skill=MS_REFLECTSHIELD
		level=5
		sp=55
		duration = 300000
	elseif (MyType==MLANCER05) then
		skill=ML_AUTOGUARD
		level=3
		sp=16
		duration = 300000
	elseif (MyType==MLANCER09) then
		skill=ML_AUTOGUARD
		level=7
		sp=24
		duration = 300000
	elseif (MyType==MLANCER10) then
		skill=ML_AUTOGUARD
		level=10
		sp=30
		duration = 300000
	end
	if (level == 0 ) then
		skill = 0
	end
	TraceAI("Defense skill is "..skill.. " Level: " ..level.. " Sp: " ..sp.. " Duration: " ..duration)
	return skill, level, sp, duration
end

function GetBerserkSkill()
	local skill = 0
	--if (HomunClass == AMISTR) then
	--	skill=HAMI_BLOODLUST
	--	level=AmistrBloodLvl
	--	sp=120
	--	duration = 60000 +((level -1)* 120000)
	if (MyType==MARCHER01) then
		skill = MER_AUTOBERSERK
	elseif (MyType==MARCHER10) then
		skill = MER_AUTOBERSERK
	elseif (MyType==MSWORDMAN07) then
		skill = MER_AUTOBERSERK
	elseif (MyType==MSWORDMAN10) then
		skill = MS_BERSERK
	elseif (MyType==MLANCER07) then
		skill = MER_AUTOBERSERK
	end
	if (level == 0 ) then
		skill = 0
	end
	TraceAI("Berserk skill is " ..skill)
	return skill
end

function GetCrashLevel()
	local level = 0
	if (MyType==MSWORDMAN05) then
		level = 4
--	elseif (MyType==MSWORDMAN04) then
--		level = 1
	elseif (MyType==MSWORDMAN09) then
		level = 3
	elseif (MyType==MLANCER04) then
		level = 4
	end
	TraceAI("Crash level is " ..level)
	return level
end

function GetRescueSkill()
	local skill = 0
	local level = 0
	local sp = 0
	if (HomunClass == AMISTR) then
		skill=HAMI_CASTLE
		level=AmistrCstLvl
		sp=(level*5) +15
	elseif (HomunClass == LIF) then
		skill=HLIF_HEAL
		level=LifHealLvl
		sp=(level*3) +10
	elseif	(MyType==MSWORDMAN07) then
		skill=MER_SCAPEGOAT
		level=1
		sp = 5
	elseif	(MyType==MLANCER08) then
		skill=MER_SCAPEGOAT
		level=1
		sp = 5
	end
	if (level == 0 ) then
		skill = 0
	end
	TraceAI("Rescue skill is "..skill.. " Level: " ..level.. " Sp: " ..sp)
	return skill,level,sp
end