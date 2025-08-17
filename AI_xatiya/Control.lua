----------------------------------------------------------------------------------------------

-----------------------------
-- state
-----------------------------
IDLE_ST					= 0
FOLLOW_ST				= 1
CHASE_ST				= 2
ATTACK_ST				= 3
MOVE_CMD_ST				= 4
STOP_CMD_ST				= 5
ATTACK_OBJECT_CMD_ST			= 6
ATTACK_AREA_CMD_ST			= 7
PATROL_CMD_ST				= 8
HOLD_CMD_ST				= 9
SKILL_OBJECT_CMD_ST			= 10
SKILL_AREA_CMD_ST			= 11
FOLLOW_CMD_ST				= 12
----------------------------



------------------------------------------
-- global variable
------------------------------------------

MyState				= FOLLOW_ST
MyDestX				= 0		
MyDestY				= 0		
ResCmdList			= List.new()
------------------------------------------

function	ProcessCommand (msg)

	if	(msg[1] == MOVE_CMD) then
		TraceAI ("MOVE_CMD")
		OnMOVE_CMD (msg[2],msg[3])
	elseif	(msg[1] == STOP_CMD) then
		TraceAI ("STOP_CMD")
		OnSTOP_CMD ()
	elseif	(msg[1] == ATTACK_OBJECT_CMD) then
		TraceAI ("ATTACK_OBJECT_CMD")
		OnATTACK_OBJECT_CMD (msg[2])
	elseif	(msg[1] == ATTACK_AREA_CMD) then
		TraceAI ("ATTACK_AREA_CMD")
		OnATTACK_AREA_CMD (msg[2],msg[3])
	elseif	(msg[1] == PATROL_CMD) then
		TraceAI ("PATROL_CMD")
		OnPATROL_CMD (msg[2],msg[3])
	elseif	(msg[1] == HOLD_CMD) then
		TraceAI ("HOLD_CMD")
		OnHOLD_CMD ()
	elseif	(msg[1] == SKILL_OBJECT_CMD) then
		TraceAI ("SKILL_OBJECT_CMD")
		OnSKILL_OBJECT_CMD (msg[2],msg[3],msg[4],msg[5])
	elseif	(msg[1] == SKILL_AREA_CMD) then
		TraceAI ("SKILL_AREA_CMD")
		OnSKILL_AREA_CMD (msg[2],msg[3],msg[4],msg[5])
	elseif	(msg[1] == FOLLOW_CMD) then
		TraceAI ("FOLLOW_CMD")
		OnFOLLOW_CMD ()
	else
		error("processcommand is" ..msg[1])
	end
end

-----------------------------------------------------------------------------------------------end







function OnOwnerHit(attackerId)
	ChaseTarget = attackerId
	if Dt[attackerId] ~= nil then
	Dt[attackerId][TARGET_ALLIANCE] = ENEMY
	end
	if ScreenEnemies then
	ScreenEnemies[attackerId] = 1000
	end
end

function OnMercenaryHit(attackerId)
        ChaseTarget = attackerId
        if Dt[attackerId] ~= nil then
                Dt[attackerId][TARGET_ALLIANCE] = ENEMY
                if Dt[attackerId][TARGET_TYPE] == IGNORETARGET or Dt[attackerId][TARGET_TYPE] == PASSIVETARGET then
                        Dt[attackerId][TARGET_TYPE] = PRIORITYTARGET
                end
        end
        if ScreenEnemies then
                ScreenEnemies[attackerId] = 1000
        end
end

if RegisterMercenaryDamageCallback then
        RegisterMercenaryDamageCallback(OnMercenaryHit)
end
if RegisterOwnerDamageCallback then
        RegisterOwnerDamageCallback(OnOwnerHit)
end

------------- command process  ---------------------

function	OnMOVE_CMD (x,y)
	TraceAI ("OnMOVE_CMD")
	ChaseCheckList = nil
	DmgCheckList = nil
	--Move (MyID,x,y)	
	MoveX = x
	MoveY = y
	GetDirection2 (OwnerX, OwnerY,MoveX, MoveY)
	MoveComplete = 0
	if ( MyType==MARCHER02 and MySP >= 10 and Buff2 < CurrentTick) then
		BuffTimers[MyID][OFFENSETIMER] = CurrentTick + 10000
		SkillObject(MyID,1,MER_SIGHT,MyID)
		UsedSkill = 1
	end
	RadialDistance = GetDistance(MoveX, MoveY, MyX, MyY)
	if (RadialDistance > 2 or MyMotion ~= MOTION_MOVE) then
		Move (MyID,MoveX,MoveY)
		MyState = MOVE_CMD_ST
	end
end




function	OnSTOP_CMD ()
	TraceAI ("OnSTOP_CMD")
	error("stop cmd")
end




function	OnATTACK_OBJECT_CMD (id)
	TraceAI ("OnATTACK_OBJECT_CMD")
	if (ManAtkType ~= NONE) then
		Dt[id][TARGET_TYPE] = ManAtkType
	end
	if (ManAtkAlliance ~= NEUTRAL) then
		Dt[id][TARGET_ALLIANCE] = ManAtkAlliance
	end
end




function	OnATTACK_AREA_CMD (x,y)
	TraceAI ("OnATTACK_AREA_CMD")
	error("atk area cmd")
end



function	OnPATROL_CMD (x,y)
	error("patrol cmd")
end




function	OnHOLD_CMD ()
	error ("hold cmd")
end




function	OnSKILL_OBJECT_CMD (level,skill,id)
	TraceAI ("OnSKILL_OBJECT_CMD")
		if (ManSkillType ~= NONE) then
			Dt[id][TARGET_TYPE] = ManSkillType
		end	
		if (ManSkillAlliance ~= NEUTRAL) then
			Dt[id][TARGET_ALLIANCE] = ManSkillAlliance
		end
		if (skill == RecoverySkill) then
			if (skill ~= MER_LEXDIVINA) then
				Dt[id][TARGET_ALLIANCE] = ALLYSTATUS
			end
		end
		if (ManSkillType ~= IGNORETARGET and ManSkillAlliance ~= IGNORE) then
			SkillObject(MyID,level,skill,id)
			UsedSkill = 1
		end
end




function	OnSKILL_AREA_CMD (level,skill,x,y)
	--TraceAI ("OnSKILL_AREA_CMD")
	--if (skill == MA_SHOWER) then
	--	ActionDistance = GetDistance(MyX,MyY,x,y)
	--	if (ActionDistance > 11) then
	--		MoveX,MoveY = CloserM(x,y,MyX,MyY,(ActionDistance - 11))
	--		MoveComplete = 0
	--		Move (MyID,MoveX,MoveY)
	--		--MoveX,MoveY = x,y
	--		MyState = MOVE_CMD_ST
	--	else
	--		SkillGround(MyID,level,skill,x,y)
	--	end
	--else
	--	--its a trapskill
	--	if (GetDistance(MyX,MyY,x,y) > 4) then
	--		Move (MyID,x,y)
	--		MyState = MOVE_CMD_ST
	--	else
	--		SkillGround(MyID,level,skill,x,y)
	--	end
	--end
	if (skill == MA_SHOWER) then
		minirange = 11
	else --trapskills
		minirange = 4
	end
	MoveX,MoveY=CloserM(MyX,MyY,x,y,minirange)
	if (MyX == MoveX and MyY == MoveY) then
		SkillGround(MyID,level,skill,x,y)
		UsedSkill = 1
		Move(MyID,MoveX,MoveY)
	else
		MoveComplete = 3
		--Move(MyID,MoveX,MoveY)
		MoveSkill = skill
		MoveLevel = level
		MyState = MOVE_CMD_ST
		AreaX,AreaY = x,y
	end
end




function	OnFOLLOW_CMD ()
	TraceAI("OnFOLLOW_CMD")
	--when you push the "merc command" button
	--TraceAI("Maxdistance is " ..MaxDistance)
	--MaxDistance = MaxDistanceX
	--TraceAI("Maxdistance changed to " ..MaxDistance)
	--error("ok")
	MyState = FOLLOW_ST
	--OnFOLLOW_ST ()
	ChaseCheckList = nil
	DmgCheckList = nil

	--PatrolX= 0
	--PatrolY = 0
	if(CurrentTick < StandbyTick and MyState ~= IDLE_ST) then
		--if (OwnerMotion == MOTION_STAND) then
			
		if (OwnerMotion == MOTION_SIT) then
			if (StandbyCounter == 3) then
				for i,v in ipairs(actors) do
					--if (v < NpcActorNumber) then --players only.
						vAlliance = Dt[v][TARGET_ALLIANCE]
						if ( vAlliance == ENEMY or vAlliance == NEUTRAL) then
							--Dt[v][TARGET_ALLIANCE] = ALLY
							Dt[v][TARGET_ALLIANCE] = ALLYALWAYS
						end
					--end
				end
				WriteDt()
				StandbyCounter = StandbyCounter +1
			elseif (StandbyCounter > 4) then
				if ( MyMercenary ~= 0) then
					Buff1 = BuffTimers[MyMercenary][DEFENSETIMER]
					Buff2 = BuffTimers[MyMercenary][OFFENSETIMER]
				end
				if ( MyHomunculus ~= 0) then
					--error("doh")
					Buff3 = BuffTimers[MyHomunculus][DEFENSETIMER]
					Buff4 = BuffTimers[MyHomunculus][OFFENSETIMER]
				end
				BuffTimers = {}
				if ( Buff1 ~= 0) then
					BuffTimers[MyMercenary] = {Buff1,Buff2}
				end
				if (Buff3 ~=0 ) then
					BuffTimers[MyHomunculus] = {Buff3,Buff4}
				end
				WriteBuffTimers()
				Dt={}
				WriteDt()
				error("ActorData Erased!" , 0)
			else
				StandbyCounter = StandbyCounter +1
			end
		else
			if (StandbyCounter == 3) then
				MyState = IDLE_ST
				HomunculusTargetLast = HomunculusTarget
				MercenaryTargetLast = MercenaryTarget
				OwnerTargetLast = OwnerTarget
				if (Dt[HomunculusTarget] ~= nil) then
					Dt[HomunculusTarget][TARGET_ALLIANCE]= NEUTRAL
				end
				if (Dt[MercenaryTarget] ~= nil) then
					Dt[MercenaryTarget][TARGET_ALLIANCE]= NEUTRAL
				end
				if (Dt[OwnerTarget] ~= nil) then
					Dt[OwnerTarget][TARGET_ALLIANCE]= NEUTRAL
				end
			elseif (StandbyCounter > 4) then
				MyState = FOLLOW_ST
			else
				StandbyCounter = StandbyCounter +1
			end
		end
	else
		if (MyState == IDLE_ST) then
			MyState = FOLLOW_ST
		end
		StandbyTick = CurrentTick + 5000
		StandbyCounter = 1
	end
end






-------------- state process  --------------------


function	OnIDLE_ST ()
	TraceAI ("OnIDLE_ST")
	--error("idlest")
	--local cmd = List.popleft(ResCmdList)
	--if (cmd ~= nil) then		
	--	ProcessCommand (cmd)	-- ����E���ɾ�Eó�� 
	--	return 
	--end
	if (MyDistance <= FollowMax and (MyDistance > 2 or MyMotion ~= MOTION_MOVE or PatrolDistance > 0)) then
		MoveToOwnerIdle()
		Move(MyID,MyDestX,MyDestY)
	elseif (MyDistance > 2 or MyMotion ~= MOTION_MOVE) then
		MoveToOwnerIdle()
		--TraceAI("Direction changed")
		--MyDirection = GetDirection2 (MyDestX, MyDestY, MyX, MyY)
		Move(MyID,MyDestX,MyDestY)
	end
end



function	OnFOLLOW_ST ()
	TraceAI ("OnFOLLOW_ST")

	-- Retirada automática al recibir daño
	if RetreatOnHit == 1 and MyMotion == MOTION_DAMAGE then
		-- Buscar el enemigo que nos ataca
		local attackerId = 0
		for v, _ in pairs(ScreenEnemies) do
			local vTarget = GetV(V_TARGET, v)
			if vTarget == MyID then
				attackerId = v
				break
			end
		end
		if attackerId ~= 0 then
			local atkX, atkY = GetV(V_POSITION, attackerId)
			-- Calcular dirección opuesta al atacante
			local dx = MyX - atkX
			local dy = MyY - atkY
			local dist = math.sqrt(dx*dx + dy*dy)
			if dist > 0 then
				local retreatX = MyX + math.floor((dx / dist) * RetreatDistance)
				local retreatY = MyY + math.floor((dy / dist) * RetreatDistance)
				Move(MyID, retreatX, retreatY)
				TraceAI("Retirada activada: alejándose de atacante " .. attackerId)
				UsedAttack = 1
				UsedSkill = 1
				return
			end
		end
	end

	-- IA completamente autónoma: revisar enemigos y usar skills en cada ciclo, igual que el Homunculus
	if (SuperAggro == 1 and EnemyCount > 0) then
		if (CurrentTick > SkillDelayTimer) then
			-- Skills de área si hay varios enemigos
			if (UseAOESkills == 1 and AOESkill ~= 0 and AOESp <= MySP and EnemyCount >= AOEMinMobCount) then
				if (AOEMethod == 0) then
					local mobcount = AOESelfCheck(AOERadius)
					if (mobcount >= AOEMinMobCount) then
						SkillObject(MyID,AOELevel,AOESkill,MyID)
						SkillDelayTimer = CurrentTick + AtkSkillDelay
						return
					end
				elseif (AOEMethod == 1) then
					local mobcount, Besttarget = AOEBestTarget(AOERange,AOERadius)
					if (mobcount >= AOEMinMobCount) then
						SkillObject(MyID,AOELevel,AOESkill,Besttarget)
						SkillDelayTimer = CurrentTick + AtkSkillDelay
						return
					end
				else
					local mobcount, Bestx, Besty = AOEBestGround(AOERange,AOERadius)
					if (mobcount >= AOEMinMobCount) then
						SkillGround(MyID,AOELevel,AOESkill,Bestx, Besty)
						SkillDelayTimer = CurrentTick + AtkSkillDelay
						return
					end
				end
			end
			-- Skills de ataque single target si hay un solo enemigo
			if (UseAtkSkills == 1 and AtkSkill ~= 0 and AtkSkillTarget ~= 0 and MySP >= AtkSkillSp) then
				SkillObject(MyID,AtkSkillLevel,AtkSkill,AtkSkillTarget)
				SkillDelayTimer = CurrentTick + AtkSkillDelay
				return
			end
		end
		-- Ataque normal si no hay skills disponibles o cooldown activo
		if (NormAtkTarget ~= 0) then
			Attack(MyID, NormAtkTarget)
		end
	end

	-- Retirada automática al recibir daño
	if RetreatOnHit == 1 and MyMotion == MOTION_DAMAGE then
		-- Buscar el enemigo que nos ataca
		local attackerId = 0
		for v, _ in pairs(ScreenEnemies) do
			local vTarget = GetV(V_TARGET, v)
			if vTarget == MyID then
				attackerId = v
				break
			end
		end
		if attackerId ~= 0 then
			local atkX, atkY = GetV(V_POSITION, attackerId)
			-- Calcular dirección opuesta al atacante
			local dx = MyX - atkX
			local dy = MyY - atkY
			local dist = math.sqrt(dx*dx + dy*dy)
			if dist > 0 then
				local retreatX = MyX + math.floor((dx / dist) * RetreatDistance)
				local retreatY = MyY + math.floor((dy / dist) * RetreatDistance)
				Move(MyID, retreatX, retreatY)
				TraceAI("Retirada activada: alejándose de atacante " .. attackerId)
				UsedAttack = 1
				UsedSkill = 1
				return
			end
		end
	end

        -- Permitir que el mercenario ataque automáticamente enemigos cercanos como el homúnculo
        if (SuperAggro == 1 and EnemyCount > 0 and UsedAttack == 0 and UsedSkill == 0) then
                if (NormAtkTarget ~= 0) then
                        Attack(MyID, NormAtkTarget)
                        UsedAttack = 1
                end
        elseif (SuperAggro == 0 and ReactiveAggro == 1 and EnemyCount > 0 and UsedAttack == 0 and UsedSkill == 0) then
                if (NormAtkTarget ~= 0) then
                        local tX, tY = GetV(V_POSITION, NormAtkTarget)
                        local tDistance = GetDistance(MyX, MyY, tX, tY)
                        if (tDistance <= MyAttackRange) then
                                Attack(MyID, NormAtkTarget)
                                UsedAttack = 1
                        end
                end
        end

	--if (MyDistance <= FollowMax) then
	if (MyDistance <= FollowMax and (MyDistance > 2 or MyMotion ~= MOTION_MOVE or PatrolDistance > 0)) then
	--if (MyDistance <= FollowMax and (MyDistance > 2 or PatrolDistance > 0)) then
	--if (MyDistance <= FollowMax and (MyMotion ~= MOTION_MOVE)) then
		if (AOESkill ~= 0 and AOESp <= MySP and UsedSkill == 0) then
			if (AOEMethod == 0) then
				mobcount=AOESelfCheck(AOERadius)
				if (mobcount >= AOEMinMobCount) then
					SkillObject(MyID,AOELevel,AOESkill,MyID)
					UsedSkill = 1
				end
			elseif (AOEMethod == 1) then
				--error("blah")
				mobcount, Besttarget = AOEBestTarget(AOERange,AOERadius)
				if (mobcount >= AOEMinMobCount) then
					--error("blah")
					SkillObject(MyID,AOELevel,AOESkill,Besttarget)
					UsedSkill = 1
				end
			else
				--if (AOESkill == MA_SHOWER) then
					--error("blah")
				--end
				mobcount, Bestx, Besty = AOEBestGround(AOERange,AOERadius)
				if (mobcount >= AOEMinMobCount) then
					SkillGround(MyID,AOELevel,AOESkill,Bestx, Besty)
					UsedSkill = 1
				end
			end
		end
		if (UsedSkill == 0) then	
			if (DecAgiAlliance ~= 0) then
				Dt[DecAgiTarget][TARGET_STATUS] = SLOWED
				Dt[DecAgiTarget][TARGET_TIMER] = CurrentTick + 10000
				SkillObject(MyID,DecAgiLevel,MER_DECAGI,DecAgiTarget)
				UsedSkill = 1
				JustSkilled = 1
			elseif (SilencePriority ~= 0 and MySP >= 20) then
				Dt[SilenceTarget][TARGET_STATUS] = SILENCED
				Dt[SilenceTarget][TARGET_TIMER] = CurrentTick + 30000
				SkillObject(MyID,1,MER_LEXDIVINA,SilenceTarget)
				UsedSkill = 1
				JustSkilled = 1
			elseif (CrashPriority ~= 0) then
				UsedSkill = 1
				JustSkilled = 1
			elseif (TrapPriority ~= 0) then
				SkillGround(MyID,TrapLevel,TrapSkill,TrapX,TrapY)
				Trap3X,Trap3Y = Trap2X,Trap2Y
				Trap2X,Trap2Y = Trap1X,Trap1Y
				Trap1X,Trap1Y = TrapX,TrapY
				Trap3Delay = Trap2Delay
				Trap2Delay = Trap1Delay
				Trap1Delay = CurrentTick +1650
				if (TrapTarget ~=0) then
					TrapAffected()
				end
				UsedSkill = 1	
			elseif (AtkSkillPriority ~= 0) then
				--Attack(MyID,AtkSkillTarget)
				--Move(MyID,MyX,MyY)
				SkillObject(MyID,AtkSkillLevel,AtkSkill,AtkSkillTarget)
				--Move(MyID,MyX,MyY)
				--Attack(MyID,AtkSkillTarget)
				UsedSkill = 1
				vType = Dt[AtkSkillTarget][TARGET_TYPE]
				if (vType > NOSKILLTARGET) then
					Dt[AtkSkillTarget][TARGET_TYPE] = vType -1
					if (SongBuffed == 0) then
						SkillDelayTimer = CurrentTick + AtkSkillDelay
					end
				end
			end

			--if (UsedSkill == 1) then
			--	if (FollowChaseDown == 0 and KiteTarget == 0) then
			--		Move(MyID,MyX,MyY)
			--	end
			--end

		end
		if (UsedAttack == 0) then
			if (NormAtkPriority ~= 0) then
				Attack(MyID,NormAtkTarget)
				TraceAI("normatktarget is: " ..NormAtkTarget)
				--if (FollowChaseDown == 0 and KiteTarget == 0) then
				--	Move(MyID,MyX,MyY)
				--end
				NormAtkTType = Dt[NormAtkTarget][TARGET_TYPE]
				if (NormAtkTType == TANKTARGET) then
					--error(Dt[NormAtkTarget][TARGET_TYPE])
					Dt[NormAtkTarget][TARGET_TYPE] = IGNORETARGET
					Dt[NormAtkTarget][TARGET_ALLIANCE] = IGNORE
					--error(Dt[NormAtkTarget][TARGET_TYPE])
				end
				--error("beepep")
--
				if (MyTarget == NormAtkTarget or NormAtkTarget ~= LastNormAtkTarget) then
					AllyCheckCounter = 0	
				else
					--if (AllyCheckCounter > 30 and (Dt[NormAtkTarget][TARGET_ALLIANCE] >= ENEMY)) then
						--Dt[NormAtkTarget][TARGET_ALLIANCE] = NEUTRAL
					if (AllyCheckCounter > 30) then
						--error("beeper")
					--	Dt[NormAtkTarget][TARGET_ALLIANCE] = ALLY
					end
					AllyCheckCounter = AllyCheckCounter +1
				end
				LastNormAtkTarget = NormAtkTarget
--
				UsedAttack = 1
			end
		end
		
		--if (UsedSkill == 1 or UsedAttack == 1) then
		--	if (FollowChaseDown == 0 and KiteTarget == 0) then
		--		Move(MyID,MyX,MyY)
		--	end
	
					--if (SuperAggro == 1 and (UsedAttack == 0 or UsedSkill == 0)) then
		if (SuperAggro == 1 and (UsedAttack == 0 or UsedSkill == 0)) then
			if (MyHPPercent >= AggroHP and MySPPercent >= AggroSP) then
				if (DmgCheckList == nil) then
					DmgCheckList = ScreenNeutrals
				end
				DmgCheckTarget = 0
				DmgCheckTarget2 = 0
				DmgCheckPriority = 30
				DmgCheckPriority2 = 30
				for v,c in pairs(DmgCheckList) do  --c is distance from self
					vX, vY = GetV (V_POSITION,v)
					vMotion = GetV(V_MOTION,v)
					vOwnerDistance = GetDistance(OwnerX, OwnerY, vX, vY)
					if (vMotion == MOTION_DEAD or vMotion == MOTION_SIT or vOwnerDistance > 14 or v < 0 ) then
						DmgCheckList[v] = nil
						c = nil
					end
					if (c ~= nil) then
						vDistance = GetDistance(MyX, MyY, vX, vY)
						vType = Dt[v][TARGET_TYPE]
						if (vDistance <= MyAttackRange and UsedAttack == 0) then
							if (vDistance < DmgCheckPriority) then
								DmgCheckTarget = v
								DmgCheckPriority = vDistance
							end
						end
						if(vDistance <= 10 and vType ~= NOSKILLTARGET and UsedSkill == 0 ) then
							if (vDistance < DmgCheckPriority2) then
								if (HomunClass == VANILMIRTH and MySP >= AtkSkillSp and VanCapriceLvl ~= 0) then
									DmgCheckSkill = HVAN_CAPRICE
									DmgCheckLvl = VanCapriceLvl
									DmgCheckTarget2 = v
									DmgCheckPriority2 = vDistance
								end
							end
						end
					end
				end	
				if (DmgCheckTarget == 0 and DmgCheckTarget2 == 0) then
					DmgCheckList = ScreenNeutrals
					for v,c in pairs(DmgCheckList) do
						vX, vY = GetV (V_POSITION,v)
						vMotion = GetV(V_MOTION,v)
						vOwnerDistance = GetDistance(OwnerX, OwnerY, vX, vY)
						if (vMotion == MOTION_DEAD or vMotion == MOTION_SIT or vOwnerDistance > 14 or v < 0 ) then
							DmgCheckList[v] = nil
							c = nil
						end
						if (c ~= nil) then
							vDistance = GetDistance(MyX, MyY, vX, vY)
							vType = Dt[v][TARGET_TYPE]
							if (vDistance <= MyAttackRange and UsedAttack == 0) then
								if (vDistance < DmgCheckPriority) then
									DmgCheckTarget = v
									DmgCheckPriority = vDistance
								end
							end
							if( vDistance <= 10 and vType ~= NOSKILLTARGET and UsedSkill == 0 ) then
								if (vDistance < DmgCheckPriority2) then
									if (HomunClass == VANILMIRTH and MySP >= AtkSkillSp and VanCapriceLvl ~= 0) then
										DmgCheckSkill = HVAN_CAPRICE
										DmgCheckLvl = VanCapriceLvl
										DmgCheckTarget2 = v
										DmgCheckPriority2 = vDistance
									--elseif (ProvLevel ~= 0 and MySP >= ProvSp) then
									--	DmgCheckSkill = MER_PROVOKE
									--	DmgCheckLvl = 1
									--	DmgCheckTarget2 = v
									--	DmgCheckPriority2 = c
									end
								end
							end
						end
					end
				end

			if (DmgCheckTarget ~= 0) then
				Attack(MyID,DmgCheckTarget)
				DmgCheckList[DmgCheckTarget] = nil
				local target = GetV(V_TARGET, DmgCheckTarget)
				if target == MyID then
					OnMercenaryHit(DmgCheckTarget)
				else
					OnOwnerHit(DmgCheckTarget)
				end
			end
			if (DmgCheckTarget2 ~= 0 and MySP >= AtkSkillSp) then
				SkillObject(MyID,DmgCheckLvl,DmgCheckSkill,DmgCheckTarget2)
				DmgCheckList[DmgCheckTarget2] = nil
				local target = GetV(V_TARGET, DmgCheckTarget2)
				if target == MyID then
					OnMercenaryHit(DmgCheckTarget2)
				else
					OnOwnerHit(DmgCheckTarget2)
				end
			end
---		
			else
				DmgCheckList = nil
			end
		end
		--if (KiteHostiles == 1) then
			ChasePriority = 30
			for v,c in pairs(KiteEnemies) do
				if (c < ChasePriority) then
					KiteTarget = v
					ChasePriority = c
				end
			end
			if (KiteTarget > 1) then
				ChaseX, ChaseY = GetV(V_POSITION,KiteTarget)
				if (MyX > ChaseX) then
					if ((ChaseX + KiteDistance) > MyX) then
						if ((math.abs(ChaseX + KiteDistance - OwnerX) <= FollowMax) and (math.abs(ChaseX + KiteDistance - OwnerX) <= MaxDistance)) then
							ChaseX = ChaseX + KiteDistance
						elseif ((MyX - ChaseX) <= math.abs(ChaseY - MyY)) then
							ChaseX = ChaseX - KiteDistance
							KiteMoveSwitch = 1
						else
							KiteMoveSwitch = 0
							ChaseX = OwnerX + FollowMax
						end
					else
						KiteMoveSwitch= 0
						ChaseX = MyX
					end
				else
					if ((ChaseX - KiteDistance) < MyX) then
						if ((math.abs(ChaseX - KiteDistance - OwnerX) <= FollowMax) and (math.abs(ChaseX - KiteDistance - OwnerX) <= MaxDistance)) then
							ChaseX = ChaseX - KiteDistance
						elseif ((ChaseX - MyX) <= math.abs(ChaseY - MyY)) then
							ChaseX = ChaseX + KiteDistance
							KiteMoveSwitch = 1
						else
							KiteMoveSwitch = 0
							ChaseX = OwnerX - FollowMax
						end
					else
						KiteMoveSwitch= 0
						ChaseX = MyX
					end
				end
				if (MyY > ChaseY) then
					if ((ChaseY + KiteDistance) > MyY) then
						if ((math.abs(ChaseY + KiteDistance - OwnerY) <= FollowMax) and (math.abs(ChaseY + KiteDistance - OwnerY) <= MaxDistance)) then
							ChaseY = ChaseY + KiteDistance
						--elseif ((MyY - ChaseY) < math.abs(ChaseX - MyX)) then
						elseif (KiteMoveSwitch == 0) then
							ChaseY = ChaseY - KiteDistance
						else
							--ChaseY = MyY
							ChaseY = OwnerY + FollowMax
						end
					else
						ChaseY = MyY
					end
				else
					if ((ChaseY - KiteDistance) < MyY) then
						if ((math.abs(ChaseY - KiteDistance - OwnerY) <= FollowMax) and (math.abs(ChaseY - KiteDistance - OwnerY) <= MaxDistance)) then
							ChaseY = ChaseY - KiteDistance
						--elseif ((ChaseY - MyY) < math.abs(ChaseX - MyX)) then
						elseif (KiteMoveSwitch == 0) then
							ChaseY = ChaseY + KiteDistance
						else
							ChaseY = OwnerY - FollowMax
						end
					else
						ChaseY = MyY
					end
				end
				if (AntiStuckTimer > CurrentTick) then
					Move(MyID,ChaseX,ChaseY)
					TraceAI("kiteing to : " ..ChaseX.. "," ..ChaseY)
				end
			end
		--end
		if (FollowChaseDown == 1 and KiteTarget == 0) then
			ChasePriority = 0
			if (ChaseCheckList == nil) then
				ChaseCheckList = ScreenNeutrals
			end

			if (ChaseTarget ~= 0) then
				ChaseX, ChaseY = GetV(V_POSITION,ChaseTarget)
				ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
				ChaseMotion = GetV(V_MOTION,ChaseTarget)
				ChaseOwnerDistance = GetDistance(OwnerX, OwnerY, ChaseX, ChaseY)
				ChaseAlliance = Dt[ChaseTarget][TARGET_ALLIANCE]
				--if ((ChaseDistance <= (MyAttackRange - 1) and ChaseAlliance == NEUTRAL and Singer ~= ChaseTarget) or ChaseTarget < 0 or ChaseMotion == MOTION_DEAD or ChaseMotion == MOTION_SIT or (ChaseOwnerDistance - MyAttackRange) > FollowMax) then
					--error("errortime")
				--	ChaseCheckList[ChaseTarget] = nil
				--	ChaseTarget = 0
				--end
---
				if (ChaseTarget < 0 or ChaseMotion == MOTION_DEAD or ChaseMotion == MOTION_SIT) then
					ChaseCheckList[ChaseTarget] = nil
					if (ChaseTarget == Singer) then
						Singer = 0
					end
					ChaseTarget = 0
				elseif (Singer ~= 0) then
					if ((ChaseOwnerDistance - 3) > FollowMax or ChaseDistance <= 3) then
						ChaseTarget = 0
						Singer = 0
					end
				elseif ((ChaseDistance <= (MyAttackRange - 1) and ChaseAlliance == NEUTRAL and MyMotion ~= MOTION_MOVE) or (ChaseOwnerDistance - (MyAttackRange - 1)) > FollowMax) then
					--if (ChaseWait < CurrentTick) then
						ChaseCheckList[ChaseTarget] = nil
						ChaseTarget = 0
					--end
				--else
					--ChaseWait = CurrentTick + 1500
				end


---
				TraceAI("chasetarget " ..ChaseTarget.. "chase x,y: " ..vX.. "," ..vY.. " motion: " ..vMotion.. " mytarget: " ..MyTarget)
			end

			if (MoveToSingers == 1) then
				if (DanceBuffed == 0) then
					ChasePriority = 30
					for v,c in pairs(DanceMakers) do
						ChaseX, ChaseY = GetV(V_POSITION,v)
						ChaseOwnerDistance = GetDistance(OwnerX, OwnerY, ChaseX, ChaseY)
						if ((ChaseOwnerDistance - 3) <= FollowMax) then
							if (c < ChasePriority) then -- c is vdistance
								ChaseTarget = v
								ChasePriority = c
								Singer = v
							end
						end
					end
				end
				if (SongBuffed == 0) then
					ChasePriority = 30
					for v,c in pairs(SongMakers) do
						ChaseX, ChaseY = GetV(V_POSITION,v)
						ChaseOwnerDistance = GetDistance(OwnerX, OwnerY, ChaseX, ChaseY)
						if ((ChaseOwnerDistance - 3) <= FollowMax) then
							if (c < ChasePriority) then -- c is vdistance
								ChaseTarget = v
								ChasePriority = c
								Singer = v
							end
						end
					end
				end
			end
	--if (ChaseTarget <= 0 and MyTarget ~= 0) then
			if (Singer == 0 and ChaseTarget <= 0 and MyTarget > 0 and Dt[MyTarget] ~= nil) then
				ChaseAlliance = Dt[MyTarget][TARGET_ALLIANCE]
				if ( ChaseAlliance ~= IGNORE) then
					ChaseMotion = GetV(V_MOTION,MyTarget)
					if (ChaseMotion ~= MOTION_DEAD and ChaseMotion ~= MOTION_SIT) then
						ChaseX, ChaseY = GetV(V_POSITION,MyTarget)
						ChaseOwnerDistance = GetDistance(OwnerX, OwnerY, ChaseX, ChaseY)
						if ((ChaseOwnerDistance - (MyAttackRange - 1)) <= FollowMax) then
							ChaseTarget = MyTarget
						end
					end
				end
			end
			ChasePriority = -200
			if (Singer == 0) then
				for v,c in pairs(ScreenEnemies) do
					ChaseMotion = GetV(V_MOTION,MyTarget)
					if (ChaseMotion ~= MOTION_DEAD and ChaseMotion ~= MOTION_SIT) then
						ChaseX, ChaseY = GetV(V_POSITION,v)
						ChaseOwnerDistance = GetDistance(OwnerX, OwnerY, ChaseX, ChaseY)
						if ((ChaseOwnerDistance - (MyAttackRange - 1)) <= FollowMax) then
							if (c > ChasePriority) then
								ChaseTarget = v
								ChasePriority = c
							end
						end
					end
				end
			end

			--if (DmgCheckTarget2 ~= 0) then
			--	ChaseTarget = DmgCheckTarget2
			--end
			if (SuperAggro == 1 and MyHPPercent >= AggroHP and MySPPercent >= AggroSP) then				
				ChasePriority = 30
				if (ChaseTarget <= 0) then
					for v,c in pairs(ChaseCheckList) do
						ChaseX, ChaseY = GetV(V_POSITION,v)
						ChaseMotion = GetV(V_MOTION,v)
						ChaseOwnerDistance = GetDistance(OwnerX, OwnerY, ChaseX, ChaseY)
						if ( v > 0 and ChaseMotion ~= MOTION_DEAD and ChaseMotion ~= MOTION_SIT and (ChaseOwnerDistance - (MyAttackRange - 1)) <= FollowMax) then
							if (c ~= nil) then
								--ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
								--if (ChaseDistance < ChasePriority) then
								if (c < ChasePriority) then
									ChaseTarget = v
									ChasePriority = ChaseDistance
								end
							end
						end
					end
				end
				if (ChaseTarget <= 0) then
					ChaseCheckList = ScreenNeutrals
					for v,c in pairs(ChaseCheckList) do
						ChaseX, ChaseY = GetV(V_POSITION,v)
						ChaseMotion = GetV(V_MOTION,v)
						ChaseOwnerDistance = GetDistance(OwnerX, OwnerY, ChaseX, ChaseY)
						if ( v > 0 and ChaseMotion ~= MOTION_DEAD and ChaseMotion ~= MOTION_SIT and (ChaseOwnerDistance - (MyAttackRange - 1)) <= FollowMax) then
							if (c ~= nil) then
								--ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
								--if (ChaseDistance < ChasePriority) then
								if (c < ChasePriority) then
									ChaseTarget = v
									ChasePriority = ChaseDistance
								end
							end
						end
					end
				end
			else
				if (ChasePriority == -200 and Singer == 0) then
					--ChaseTarget = 0
					ChaseCheckList = nil
				end
				--ChaseCheckList = nil
			end
			--if (ChaseTarget > 0 and (MyMotion ~= MOTION_MOVE or ChaseChange == 1 or UsedAttack ==1 or UsedSkill==1)) then
			if (ChaseTarget > 0) then
				--ChaseChange = 0
				ChaseX, ChaseY = GetV(V_POSITION,ChaseTarget)
				ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
				if (ChaseDistance > FollowMax) then
					Move(MyID,OwnerX,OwnerY)
					ChaseTarget = 0
				elseif (Singer ~= 0) then
					Move(MyID,ChaseX,ChaseY)
				elseif (ChaseDistance >= (MyAttackRange - 1) ) then
					if (math.abs(OwnerX - ChaseX) > FollowMax) then
						if (ChaseX > OwnerX) then
							ChaseX = (OwnerX + FollowMax)
						else
							ChaseX = (OwnerX - FollowMax)
						end
					end
					if (math.abs(OwnerY - ChaseY) > FollowMax) then
						if (ChaseY > OwnerY) then
							ChaseY = (OwnerY + FollowMax)
						else
							ChaseY = (OwnerY - FollowMax)
						end
					end
					if (AntiStuckTimer > CurrentTick) then
						Move(MyID,ChaseX,ChaseY)
					end
				elseif (ChaseTarget == Singer) then
					Move(MyID,ChaseX,ChaseY)
				elseif (UsedAttack == 1 or UsedSkill ==1) then
					else
						Move(MyID,MyX,MyY)
				end
				--error("beep")
			--else				
				--TrapFormation1()
				--MoveToOwnerDest()
				--if ( MyX == MyDestX and MyY == MyDestY and MySPPercent > TrapFollowSP and TrapLevel2 ~=0) then
				--	if (TrapFollowForm ==1) then
				--		TrapFormation1()
				--	elseif (TrapFollowForm ==2) then
				--		TrapFormation2()
				--	elseif (TrapFollowForm ==3) then
				--		TrapFormation3()
				--	elseif (TrapFollowForm ==4) then
				----		TrapFormation4()
				--	end
				--end
				--Move(MyID,MyDestX,MyDestY)
			end
		end
		TraceAI("ChaseTarget is " ..ChaseTarget)
		--if (ChaseTarget <= 0 and KiteTarget == 0) then
			--TraceAI("ChaseTarget is " ..ChaseTarget)
			MoveToOwnerDest()
			if ( MyX == MyDestX and MyY == MyDestY and UsedSkill == 0 and MySPPercent > TrapFollowSP and TrapLevel2 ~=0) then
				UsedSkill = 1
				if (TrapFollowForm ==1) then
					TrapFormation1()
				elseif (TrapFollowForm ==2) then
					TrapFormation2()
				elseif (TrapFollowForm ==3) then
					TrapFormation3()
				elseif (TrapFollowForm ==4) then
					TrapFormation4()
				else
					UsedSkill = 0
				end
				--MoveToOwnerDest()
				Move(MyID,MyDestX,MyDestY)
			end
--cleanup later
			if (MySP > (MyMaxSP - 40) and MyMaxSP > 40 and HomumClass ~= 0 and VanUseChaotic ==1 and UsedSkill == 0 and (OwnerHPPercent < 90 or MyHPPercent < 90)) then
				UsedSkill = 1
				if (OwnerHPPercent < 90 and MyHPPercent < 90) then
					SkillObject(MyID,5,HVAN_CHAOTIC,MyID)
				elseif (OwnerHPPercent < 85) then
					SkillObject(MyID,3,HVAN_CHAOTIC,MyID)
				elseif (MyHPPercent < 85 ) then
					SkillObject(MyID,4,HVAN_CHAOTIC,MyID)
				else
					UsedSkill = 0
				end
				--Move(MyID,MyDestX,MyDestY)
			end
		if (ChaseTarget <= 0 and KiteTarget == 0) then
			if (PatrolDistance > 0 and PatrolDistance <= FollowMax and TrapFollowForm == 0) then
				if ( GetDistance(MyX, MyY, PatrolX, PatrolY) <= 1 ) then
					PatrolCounter = PatrolCounter + 1
				end
				if (PatrolType == 1) then 				--box
					if (PatrolCounter == 4) then
						PatrolCounter = 0
					end
					if (PatrolCounter == 0) then
						PatrolX = OwnerX - PatrolDistance
						PatrolY = OwnerY + PatrolDistance
					elseif (PatrolCounter == 1) then
						PatrolX = OwnerX + PatrolDistance
						PatrolY = OwnerY + PatrolDistance
					elseif (PatrolCounter == 2) then
						PatrolX = OwnerX + PatrolDistance
						PatrolY = OwnerY - PatrolDistance
					elseif (PatrolCounter == 3) then
						PatrolX = OwnerX - PatrolDistance
						PatrolY = OwnerY - PatrolDistance
					end
				else 							-- diamond
					if (PatrolCounter == 4) then
						PatrolCounter = 0
					end
					if (PatrolCounter == 0) then
						PatrolX = OwnerX
						PatrolY = OwnerY + PatrolDistance
					elseif (PatrolCounter == 1) then
						PatrolX = OwnerX + PatrolDistance
						PatrolY = OwnerY
					elseif (PatrolCounter == 2) then
						PatrolX = OwnerX
						PatrolY = OwnerY - PatrolDistance
					elseif (PatrolCounter == 3) then
						PatrolX = OwnerX - PatrolDistance
						PatrolY = OwnerY
					end
				end
				if (AntiStuckTimer > CurrentTick) then
					Move(MyID,PatrolX,PatrolY)
				end
			else
				Move(MyID,MyDestX,MyDestY)
			end
		end

		
	elseif (MyDistance > 2 or MyMotion ~= MOTION_MOVE) then
		MoveToOwnerDest()
		--TraceAI("Direction changed")
		--MyDirection = GetDirection2 (MyDestX, MyDestY, MyX, MyY)
		Move(MyID,MyDestX,MyDestY)
	end
end




function	OnCHASE_ST ()
	error("OnCHASE_ST")
end

function	OnATTACK_ST ()
	error("OnATTACK_ST")
end




function	OnMOVE_CMD_ST ()
	TraceAI ("OnMOVE_CMD_ST")
	--if (MoveComplete == 0 and MyMotion ~= MOTION_MOVE and MyX == MoveX and MyY == MoveY) then
	if (MoveComplete < 4) then
		if (MyX == MoveX and MyY == MoveY) then
			if ( DecloakSkill==MS_MAGNUM) then
				if (MySP >= DecloakSp) then
					SkillObject(MyID,DecloakLevel,DecloakSkill,MyID)
					UsedSkill = 1
				end
			elseif (MoveSkill ~= 0) then
				SkillGround(MyID,MoveLevel,MoveSkill,AreaX,AreaY)
				UsedSkill = 1
			end
			MoveComplete = MoveComplete + 1
		end
		--if (MyMotion ~= MOTION_MOVE) then
			Move(MyID,MoveX,MoveY)
		--end
	end
	if (MoveComplete == 4) then
		RadialDistance = GetDistance(MoveX, MoveY, MyX, MyY)
		--if (RadialDistance <= MoveRadius and (RadialDistance > 2 or MyMotion ~= MOTION_MOVE or PatrolDistance > 0)) then
		if (RadialDistance <= MoveRadius) then
			if (AOESkill ~= 0 and AOESp <= MySP and UsedSkill == 0) then
				if (AOEMethod == 0) then
					mobcount=AOESelfCheck(AOERadius)
					if (mobcount >= AOEMinMobCount) then
						SkillObject(MyID,AOELevel,AOESkill,MyID)
						UsedSkill = 1
					end
				elseif (AOEMethod == 1) then
					mobcount, Besttarget = AOEBestTarget(AOERange,AOERadius)
					if (mobcount >= AOEMinMobCount) then
						SkillObject(MyID,AOELevel,AOESkill,Besttarget)
						UsedSkill = 1
					end
				else
					mobcount, Bestx, Besty = AOEBestGround(AOERange,AOERadius)
					if (mobcount >= AOEMinMobCount) then
						SkillGround(MyID,AOELevel,AOESkill,Bestx, Besty)
						UsedSkill = 1
					end
				end
			end
			if (UsedSkill == 0) then	
				if (DecAgiAlliance ~= 0) then
					Dt[DecAgiTarget][TARGET_STATUS] = SLOWED
					Dt[DecAgiTarget][TARGET_TIMER] = CurrentTick + 10000
					SkillObject(MyID,DecAgiLevel,MER_DECAGI,DecAgiTarget)
					UsedSkill = 1
					JustSkilled = 2
				elseif (SilencePriority ~= 0 and MySP >= 20) then
					Dt[SilenceTarget][TARGET_STATUS] = SILENCED
					Dt[SilenceTarget][TARGET_TIMER] = CurrentTick + 30000
					SkillObject(MyID,1,MER_LEXDIVINA,SilenceTarget)
					UsedSkill = 1
					JustSkilled = 1
				elseif (CrashPriority ~= 0) then
					UsedSkill = 1
					JustSkilled = 1
				elseif (TrapPriority ~= 0) then
					SkillGround(MyID,TrapLevel,TrapSkill,TrapX,TrapY)
					Trap3X,Trap3Y = Trap2X,Trap2Y	
					Trap2X,Trap2Y = Trap1X,Trap1Y
					Trap1X,Trap1Y = TrapX,TrapY
					Trap3Delay = Trap2Delay
					Trap2Delay = Trap1Delay
					Trap1Delay = CurrentTick +1650
					if (TrapTarget ~=0) then
						TrapAffected()
					end
					UsedSkill = 1	
				elseif (AtkSkillPriority ~= 0) then
					SkillObject(MyID,AtkSkillLevel,AtkSkill,AtkSkillTarget)
					UsedSkill = 1
					vType = Dt[AtkSkillTarget][TARGET_TYPE]
					if (vType > NOSKILLTARGET) then
						Dt[AtkSkillTarget][TARGET_TYPE] = vType -1
						if (SongBuffed == 0) then
							SkillDelayTimer = CurrentTick + AtkSkillDelay
						end
					end
				end

				--if (UsedSkill == 1) then
				--	if (MoveChaseDown == 0) then
				--		Move(MyID,MyX,MyY)
				--	end
				--end
			end
			if (UsedAttack == 0) then
				if (NormAtkPriority ~= 0) then
					Attack(MyID,NormAtkTarget)
					TraceAI("normatktarget is: " ..NormAtkTarget)
					--if (MoveChaseDown == 0) then
						--error("atked")
					--	Move(MyID,MyX,MyY)
					--end
					NormAtkTType = Dt[NormAtkTarget][TARGET_TYPE]
					if (NormAtkTType == TANKTARGET) then
						Dt[NormAtkTarget][TARGET_TYPE] = IGNORETARGET
						Dt[NormAtkTarget][TARGET_ALLIANCE] = IGNORE
					end
					if (MyTarget == NormAtkTarget or NormAtkTarget ~= LastNormAtkTarget) then
						AllyCheckCounter = 0	
					else
						
						if (AllyCheckCounter > 30 and (Dt[NormAtkTarget][TARGET_ALLIANCE] >= ENEMY)) then
							Dt[NormAtkTarget][TARGET_ALLIANCE] = NEUTRAL
						end
						AllyCheckCounter = AllyCheckCounter +1
					end
					LastNormAtkTarget = NormAtkTarget
					UsedAttack = 1
				end
			end

			--if (UsedSkill == 1 or UsedAttack == 1) then
			--	if (MoveChaseDown == 0 and KiteTarget == 0) then
			--		Move(MyID,MyX,MyY)
			--	end

					--if (SuperAggro == 1 and (UsedAttack == 0 or UsedSkill == 0)) then
			if (SuperAggro == 1 and (UsedAttack == 0 or UsedSkill == 0) and MyHPPercent >= AggroHP and MySPPercent >= AggroSP) then
				if (DmgCheckList == nil) then
					DmgCheckList = ScreenNeutrals
				end
				DmgCheckTarget = 0
				DmgCheckTarget2 = 0
				DmgCheckPriority = 30
				DmgCheckPriority2 = 30
				for v,c in pairs(DmgCheckList) do
					vX, vY = GetV (V_POSITION,v)
					vMotion = GetV(V_MOTION,v)
					vOwnerDistance = GetDistance(OwnerX, OwnerY, vX, vY)
					if (vMotion == MOTION_DEAD or vMotion == MOTION_SIT or vOwnerDistance > 14 or v < 0 ) then
						DmgCheckList[v] = nil
						c = nil
					end
					if (c ~= nil) then
						vDistance = GetDistance(MyX, MyY, vX, vY)
						vType = Dt[v][TARGET_TYPE]
						if (vDistance <= MyAttackRange and UsedAttack == 0) then
							if (c < DmgCheckPriority) then
								DmgCheckTarget = v
								DmgCheckPriority = c
							end
						end
						if( vDistance <= 10 and vType ~= NOSKILLTARGET and UsedSkill == 0 ) then
							if (c < DmgCheckPriority2) then
								if (HomunClass == VANILMIRTH and MySP >= AtkSkillSp and VanCapriceLvl ~= 0) then
									DmgCheckSkill = HVAN_CAPRICE
									DmgCheckLvl = VanCapriceLvl
									DmgCheckTarget2 = v
									DmgCheckPriority2 = c
								--elseif (ProvLevel ~= 0 and MySP >= ProvSp) then
								--	DmgCheckSkill = MER_PROVOKE
								--	DmgCheckLvl = 1
								--	DmgCheckTarget2 = v
								--	DmgCheckPriority2 = c
								end
							end
						end
					end
				end	
				if (DmgCheckTarget == 0 and DmgCheckTarget2 == 0) then
					DmgCheckList = ScreenNeutrals
					DmgCheckTarget = 0
					DmgCheckTarget2 = 0
					DmgCheckPriority = 30
					DmgCheckPriority2 = 30
					for v,c in pairs(DmgCheckList) do
						vX, vY = GetV (V_POSITION,v)
						vMotion = GetV(V_MOTION,v)
						vOwnerDistance = GetDistance(OwnerX, OwnerY, vX, vY)
						if (vMotion == MOTION_DEAD or vMotion == MOTION_SIT or vOwnerDistance > 14 or v < 0 ) then
							DmgCheckList[v] = nil
							c = nil
						end
						if (c ~= nil) then
							vDistance = GetDistance(MyX, MyY, vX, vY)
							vType = Dt[v][TARGET_TYPE]
							if (vDistance <= MyAttackRange and UsedAttack == 0) then
								if (c < DmgCheckPriority) then
									DmgCheckTarget = v
									DmgCheckPriority = c
								end
							end
							if( vDistance <= 10 and vType ~= NOSKILLTARGET and UsedSkill == 0 ) then
								if (c < DmgCheckPriority2) then
									if (HomunClass == VANILMIRTH and MySP >= AtkSkillSp and VanCapriceLvl ~= 0) then
									DmgCheckSkill = HVAN_CAPRICE
										DmgCheckLvl = VanCapriceLvl
										DmgCheckTarget2 = v
										DmgCheckPriority2 = c
									--elseif (ProvLevel ~= 0 and MySP >= ProvSp) then
									--	DmgCheckSkill = MER_PROVOKE
									--	DmgCheckLvl = 1
									--	DmgCheckTarget2 = v
									--	DmgCheckPriority2 = c
									end
								end
							end
						end
					end
				end
			if (DmgCheckTarget ~= 0) then
				Attack(MyID,DmgCheckTarget)
				DmgCheckList[DmgCheckTarget] = nil
				local target = GetV(V_TARGET, DmgCheckTarget)
				if target == MyID then
					OnMercenaryHit(DmgCheckTarget)
				else
					OnOwnerHit(DmgCheckTarget)
				end
			end
			if (DmgCheckTarget2 ~= 0 and MySP >= AtkSkillSp) then
				SkillObject(MyID,DmgCheckLvl,DmgCheckSkill,DmgCheckTarget2)
				DmgCheckList[DmgCheckTarget2] = nil
				local target = GetV(V_TARGET, DmgCheckTarget2)
				if target == MyID then
					OnMercenaryHit(DmgCheckTarget2)
				else
					OnOwnerHit(DmgCheckTarget2)
				end
			end
			else
				DmgCheckList = nil
			end
		
			ChasePriority = 30
			for v,c in pairs(KiteEnemies) do
				if (c < ChasePriority) then
					KiteTarget = v
					ChasePriority = c
				end
			end
			if (KiteTarget > 1) then 
				ChaseX, ChaseY = GetV(V_POSITION,KiteTarget)
				if (MyX > ChaseX) then
					if ((ChaseX + KiteDistance) > MyX) then
						if ((math.abs(ChaseX + KiteDistance - MoveX) <= MoveRadius) and (math.abs(ChaseX + KiteDistance - OwnerX) <= MaxDistance)) then
							ChaseX = ChaseX + KiteDistance
						elseif ((MyX - ChaseX) <= math.abs(ChaseY - MyY)) then
							ChaseX = ChaseX - KiteDistance
							KiteMoveSwitch = 1
						else
							KiteMoveSwitch = 0
							ChaseX = MoveX + MoveRadius
						end
					else
						KiteMoveSwitch= 0
						ChaseX = MyX
					end
				else
					if ((ChaseX - KiteDistance) < MyX) then
						if ((math.abs(ChaseX - KiteDistance - MoveX) <= MoveRadius) and (math.abs(ChaseX - KiteDistance - OwnerX) <= MaxDistance)) then
							ChaseX = ChaseX - KiteDistance
						elseif ((ChaseX - MyX) <= math.abs(ChaseY - MyY)) then
							ChaseX = ChaseX + KiteDistance
							KiteMoveSwitch = 1
						else
							KiteMoveSwitch = 0
							ChaseX = MoveX - MoveRadius
						end
					else
						KiteMoveSwitch= 0
						ChaseX = MyX
					end
				end
				if (MyY > ChaseY) then
					if ((ChaseY + KiteDistance) > MyY) then
						if ((math.abs(ChaseY + KiteDistance - MoveY) <= MoveRadius) and (math.abs(ChaseY + KiteDistance - OwnerY) <= MaxDistance)) then
							ChaseY = ChaseY + KiteDistance
						--elseif ((MyY - ChaseY) < math.abs(ChaseX - MyX)) then
						elseif (KiteMoveSwitch == 0) then
							ChaseY = ChaseY - KiteDistance
						else
							--ChaseY = MyY
							ChaseY = MoveY + MoveRadius
						end
					else
						ChaseY = MyY
					end
				else
					if ((ChaseY - KiteDistance) < MyY) then
						if ((math.abs(ChaseY - KiteDistance - MoveY) <= MoveRadius) and (math.abs(ChaseY - KiteDistance - OwnerY) <= MaxDistance)) then
							ChaseY = ChaseY - KiteDistance
						--elseif ((ChaseY - MyY) < math.abs(ChaseX - MyX)) then
						elseif (KiteMoveSwitch == 0) then
							ChaseY = ChaseY + KiteDistance
						else
							ChaseY = MoveY - MoveRadius
						end
					else
						ChaseY = MyY
					end
				end
				if (AntiStuckTimer > CurrentTick) then
					Move(MyID,ChaseX,ChaseY)
					TraceAI("kiteing to : " ..ChaseX.. "," ..ChaseY)
				end
			end
			if (MoveChaseDown == 1 and KiteTarget == 0) then
				ChasePriority = 0
				if (ChaseCheckList == nil) then
					ChaseCheckList = ScreenNeutrals
				end
				if (ChaseTarget ~= 0) then
					ChaseX, ChaseY = GetV(V_POSITION,ChaseTarget)
					ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
					ChaseMotion = GetV(V_MOTION,ChaseTarget)
					ChaseRadialDistance = GetDistance(MoveX, MoveY, ChaseX, ChaseY)
					ChaseAlliance = Dt[ChaseTarget][TARGET_ALLIANCE]
					if (ChaseTarget < 0 or ChaseMotion == MOTION_DEAD or ChaseMotion == MOTION_SIT) then
						ChaseCheckList[ChaseTarget] = nil
						if (ChaseTarget == Singer) then
							Singer = 0
						end
						ChaseTarget = 0
					elseif (Singer ~= 0) then
						if ((ChaseRadialDistance - 3) > MoveRadius or ChaseDistance <= 3) then
							ChaseTarget = 0
							Singer = 0
						end
					elseif ((ChaseDistance <= (MyAttackRange - 1) and ChaseAlliance == NEUTRAL and MyMotion ~= MOTION_MOVE) or (ChaseRadialDistance - (MyAttackRange - 1)) > MoveRadius) then
						ChaseCheckList[ChaseTarget] = nil
						ChaseTarget = 0
					end
					TraceAI("chasetarget " ..ChaseTarget.. "chase x,y: " ..vX.. "," ..vY.. " motion: " ..vMotion.. " mytarget: " ..MyTarget)
				end--
				if (MoveToSingers == 1) then
					if (DanceBuffed == 0) then
						ChasePriority = 30
						for v,c in pairs(DanceMakers) do
							ChaseX, ChaseY = GetV(V_POSITION,v)
							ChaseRadialDistance = GetDistance(MoveX, MoveY, ChaseX, ChaseY)
							if ((ChaseRadialDistance - 3) <= MoveRadius) then
								if (c < ChasePriority) then -- c is vdistance
									ChaseTarget = v
									ChasePriority = c
									Singer = v
								end
							end
						end
					end
					if (SongBuffed == 0) then
						ChasePriority = 30
						for v,c in pairs(SongMakers) do
							ChaseX, ChaseY = GetV(V_POSITION,v)
							ChaseRadialDistance = GetDistance(MoveX, MoveY, ChaseX, ChaseY)
							if ((ChaseRadialDistance - 3) <= MoveRadius) then
								if (c < ChasePriority) then -- c is vdistance
									ChaseTarget = v
									ChasePriority = c
									Singer = v
								end
							end
						end
					end
				end---
				if (Singer == 0 and ChaseTarget <= 0 and MyTarget > 0 and Dt[MyTarget] ~= nil) then
					ChaseAlliance = Dt[MyTarget][TARGET_ALLIANCE]
					if ( ChaseAlliance ~= IGNORE) then
						ChaseX, ChaseY = GetV(V_POSITION,MyTarget)
						ChaseMotion = GetV(V_MOTION,MyTarget)
						ChaseRadialDistance = GetDistance(MoveX, MoveY, ChaseX, ChaseY)
						if ( MyTarget > 0 and ChaseMotion ~= MOTION_DEAD and ChaseMotion ~= MOTION_SIT and (ChaseRadialDistance - (MyAttackRange - 1)) <= MoveRadius) then
							ChaseTarget = MyTarget
						end
					end
				end
				ChasePriority = -200
				if (Singer == 0) then
					for v,c in pairs(ScreenEnemies) do
						ChaseX, ChaseY = GetV(V_POSITION,v)
						--ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
						ChaseMotion = GetV(V_MOTION,v)
						ChaseRadialDistance = GetDistance(MoveX, MoveY, ChaseX, ChaseY)
						if ( v > 0 and ChaseMotion ~= MOTION_DEAD and ChaseMotion ~= MOTION_SIT and (ChaseRadialDistance - (MyAttackRange - 1)) <= MoveRadius) then
							if (c > ChasePriority) then
								ChaseTarget = v
								ChasePriority = c
							end
						end
					end
				end
				if (SuperAggro == 1 and MyHPPercent >= AggroHP and MySPPercent >= AggroSP) then
					ChasePriority = 30
					if (ChaseTarget <= 0) then
						for v,c in pairs(ChaseCheckList) do
							ChaseX, ChaseY = GetV(V_POSITION,v)
							--ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
							ChaseMotion = GetV(V_MOTION,v)
							ChaseRadialDistance = GetDistance(MoveX, MoveY, ChaseX, ChaseY)
							if ( v > 0 and ChaseMotion ~= MOTION_DEAD and ChaseMotion ~= MOTION_SIT and (ChaseRadialDistance - (MyAttackRange - 1)) <= MoveRadius) then
								if (c ~= nil) then
									--if (DmgCheckTarget2 ~= v and DmgCheckTarget2 > 0) then
									--	ChaseTarget = DmgCheckTarget2
									--	ChasePriority = 0
									--end
									if (c < ChasePriority) then
										ChaseTarget = v
										ChasePriority = c
									end
								end
							end
						end
					end
					if (ChaseTarget <= 0 ) then
						ChaseCheckList = ScreenNeutrals
						for v,c in pairs(ChaseCheckList) do
							ChaseX, ChaseY = GetV(V_POSITION,v)
							--ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
							ChaseMotion = GetV(V_MOTION,v)
							ChaseRadialDistance = GetDistance(MoveX, MoveY, ChaseX, ChaseY)
							if ( v > 0 and ChaseMotion ~= MOTION_DEAD and ChaseMotion ~= MOTION_SIT and (ChaseRadialDistance - (MyAttackRange - 1)) <= MoveRadius) then
								if (c ~= nil) then
									--if (DmgCheckTarget2 ~= v and DmgCheckTarget2 > 0) then
									--	ChaseTarget = DmgCheckTarget2
									--	ChasePriority = 0
									--end
									if (c < ChasePriority) then
										ChaseTarget = v
										ChasePriority = c
									end
								end
							end
						end
						--if (ChaseTarget <= 0) then
						--	ChaseWait = 0
						--end
					end
				else
					if (ChasePriority == -200 and Singer == 0) then
						--ChaseTarget = 0
						ChaseCheckList = nil
					end
				end

				if (ChaseTarget > 0) then
					ChaseX, ChaseY = GetV(V_POSITION,ChaseTarget)
					ChaseDistance = GetDistance(MyX, MyY, ChaseX, ChaseY)
					if (ChaseDistance > 14 ) then
						Move(MyID,OwnerX,OwnerY)
					elseif (Singer ~= 0) then
						Move(MyID,ChaseX,ChaseY)
					elseif (ChaseDistance >= (MyAttackRange - 1)) then
						if (math.abs(MoveX - ChaseX) > MoveRadius) then
							if (ChaseX > MoveX) then
								ChaseX = (MoveX + MoveRadius)
							else
								ChaseX = (MoveX - MoveRadius)
							end
						end
						if (math.abs(MoveY - ChaseY) > MoveRadius) then
							if (ChaseY > MoveY) then
								ChaseY = (MoveY + MoveRadius)
							else
								ChaseY = (MoveY - MoveRadius)
							end
						end
						if (AntiStuckTimer > CurrentTick) then
							Move(MyID,ChaseX,ChaseY)
						end
					elseif (UsedAttack == 1 or UsedSkill ==1) then
						Move(MyID,MyX,MyY)
					end
				end
			end
			--if (ChaseTarget <= 0 and KiteTarget == 0) then
				if ( MyX == MoveX and MyY == MoveY and UsedSkill == 0 and MySPPercent > TrapMoveSP and TrapLevel2 ~=0) then
					UsedSkill = 1
					if (TrapMoveForm ==1) then
						TrapFormation1()
					elseif (TrapMoveForm ==2) then
						TrapFormation2()
					elseif (TrapMoveForm ==3) then
						TrapFormation3()
					elseif (TrapMoveForm ==4) then
						TrapFormation4()
					elseif (TrapMoveForm ==5) then
						TrapFormation5()
					else
						UsedSkill = 0
					end
					Move(MyID,MoveX,MoveY)
				end	
				if (MySP > (MyMaxSP - 40) and MyMaxSP > 40 and HomumClass ~= 0 and VanUseChaotic ==1 and UsedSkill == 0 and (OwnerHPPercent < 90 or MyHPPercent < 90)) then
					UsedSkill = 1
					if (OwnerHPPercent < 90 and MyHPPercent < 90) then
						SkillObject(MyID,5,HVAN_CHAOTIC,MyID)
					elseif (OwnerHPPercent < 85) then
						SkillObject(MyID,3,HVAN_CHAOTIC,MyID)
					elseif (MyHPPercent < 85 ) then
						SkillObject(MyID,4,HVAN_CHAOTIC,MyID)
					else
						UsedSkill = 0
					end
					--Move(MyID,MoveX,MoveY)
				end
			if (ChaseTarget <= 0 and KiteTarget == 0) then
				if (PatrolDistance > 0 and PatrolDistance <= MoveRadius and TrapMoveForm == 0) then
					if ( GetDistance(MyX, MyY, PatrolX, PatrolY) <= 1 ) then
						PatrolCounter = PatrolCounter + 1
					end
					if (PatrolType == 1) then
						if (PatrolCounter == 4) then
							PatrolCounter = 0
						end
						if (PatrolCounter == 0) then
							PatrolX = MoveX - PatrolDistance
							PatrolY = MoveY + PatrolDistance
						elseif (PatrolCounter == 1) then
							PatrolX = MoveX + PatrolDistance
							PatrolY = MoveY + PatrolDistance
						elseif (PatrolCounter == 2) then
							PatrolX = MoveX + PatrolDistance
							PatrolY = MoveY - PatrolDistance
						elseif (PatrolCounter == 3) then
							PatrolX = MoveX - PatrolDistance
							PatrolY = MoveY - PatrolDistance
						end
					else
						if (PatrolCounter == 4) then
							PatrolCounter = 0
						end
						if (PatrolCounter == 0) then
							PatrolX = MoveX
							PatrolY = MoveY + PatrolDistance
						elseif (PatrolCounter == 1) then
							PatrolX = MoveX + PatrolDistance
							PatrolY = MoveY
						elseif (PatrolCounter == 2) then
							PatrolX = MoveX
							PatrolY = MoveY - PatrolDistance
						elseif (PatrolCounter == 3) then
							PatrolX = MoveX - PatrolDistance
							PatrolY = MoveY
						end
					end
					if (AntiStuckTimer > CurrentTick) then
						Move(MyID,PatrolX,PatrolY)
					end
				--else
					--Move(MyID,MoveX,MoveY)
				elseif (MyMotion ~= MOTION_MOVE) then
					Move(MyID,MoveX,MoveY)
				end
			end
--necessary?
		elseif (MyMotion ~= MOTION_MOVE) then
			Move(MyID,MoveX,MoveY)
		end
	end
end




function OnSTOP_CMD_ST ()
	error("OnSTOP_CMD_ST")
	TraceAI ("OnSTOP_CMD_ST")

end




function OnATTACK_OBJECT_CMD_ST ()
	error("OnATTACK_OBJECT_CMD_ST")
	TraceAI ("OnATTACK_OBJECT_CMD_ST")
	

end




function OnATTACK_AREA_CMD_ST ()
	error("OnATTACK_AREA_CMD_ST")
	TraceAI ("OnATTACK_AREA_CMD_ST")

	local	object = GetOwnerEnemy (MyID)
	if (object == 0) then							
		object = GetMyEnemy (MyID) 
	end

	if (object ~= 0) then							-- MYOWNER_ATTACKED_IN or ATTACKED_IN
		MyState = CHASE_ST
		MyEnemy = object
		return
	end

	local x , y = GetV (V_POSITION,MyID)
	if (x == MyDestX and y == MyDestY) then			-- DESTARRIVED_IN
			MyState = IDLE_ST
	end

end




function OnPATROL_CMD_ST ()
	error("OnPATROL_CMD_ST")
	TraceAI ("OnPATROL_CMD_ST")

	local	object = GetOwnerEnemy (MyID)
	if (object == 0) then							
		object = GetMyEnemy (MyID) 
	end

	if (object ~= 0) then							-- MYOWNER_ATTACKED_IN or ATTACKED_IN
		MyState = CHASE_ST
		MyEnemy = object
		TraceAI ("PATROL_CMD_ST -> CHASE_ST : ATTACKED_IN")
		return
	end

	local x , y = GetV (V_POSITION,MyID)
	if (x == MyDestX and y == MyDestY) then			-- DESTARRIVED_IN
		MyDestX = MyPatrolX
		MyDestY = MyPatrolY
		MyPatrolX = x
		MyPatrolY = y
		Move (MyID,MyDestX,MyDestY)
	end

end




function OnHOLD_CMD_ST ()
	error("OnHOLD_CMD_ST")
end




function OnSKILL_OBJECT_CMD_ST ()
	TraceAI("OnSKILL_OBJECT_CMD_ST")
	error("OnSKILL_OBJECT_CMD_ST")
end




function OnSKILL_AREA_CMD_ST ()
	error("OnSKILL_AREA_CMD_ST")
	TraceAI ("OnSKILL_AREA_CMD_ST")

	if (MySkill == MA_SHOWER) then
		if (GetDistance(MyX,MyY,MyDestX,MyDestY) <= 11) then	
			SkillGround (MyID,MySkillLevel,MySkill,MyDestX,MyDestY)
			MyState = FOLLOW_ST
			MySkill = 0
		end
	else
		if (GetDistance(MyX,MyY,MyDestX,MyDestY) <= 4) then
			SkillGround (MyID,MySkillLevel,MySkill,MyDestX,MyDestY)
			MyState = FOLLOW_ST
			MySkill = 0
		end
	end
end







function OnFOLLOW_CMD_ST ()
	error("OnFOLLOW_CMD_ST")
end










--lua version 5.0.2
function AI(myid)	
	TraceAI("AI cycle start" ..GetTick())
	if (OneTimeCheck == 1 ) then	--run only once

		--errored = pcall(dofile, ("AI_xatiya/ActorList.lua"))
		--if (pcall(dofile, ("AI_xatiya/ActorList.lua")) ~= 0) then
		--	WriteActorInfo = 0
		--	Dt = {}
		--	WriteDt()
		--error("actorlist fail")
		--end

		--errorthing = xpcall(error("AI_xatiya/ActorList.lua"))
		--errorthing = pcall(dofile("AI_xatiya/ActorList.lua"))
		--error(errorthing)

		--if pcall(dofile, ("AI_xatiya/ActorList.lua")) == 1) then
		--	BuffTimers = {}
		--	WriteBuffTimers()
		--	error("bufftimer fail")
		--end
		if (errored == 1) then
			errored = errored * 2
			dofile ("AI_xatiya/Timeout.txt")
			dofile ("AI_xatiya/ActorList.txt")
			errored = 0
			--error("blah")
		else
			--Dt = {}
			--WriteDt()
			--BuffTimers = {}
			--WriteBuffTimers()
			--errored = 0
		end	


		--MySpawnTime	= GetTick()
		AntiStuckTimer = MySpawnTime + 3000
		--AFKTimer = MySpawnTime + AFKCountDown
		MyID = myid
		MyOwner = GetV(V_OWNER,myid)
		MyX,MyY = GetV(V_POSITION,myid)
		OwnerX, OwnerY = GetV(V_POSITION,MyOwner)
		OwnerMotion = GetV(V_MOTION,MyOwner)
		MyMaxHP=GetV(V_MAXHP,myid)
		MyMaxSP=GetV(V_MAXSP,myid)
		MyType=GetV(V_HOMUNTYPE,myid)
		MyAttackRange= GetAttackRange()
		MyDestX,MyDestY = OwnerX,OwnerY
		OwnerLastX = OwnerX
		OwnerLastY = OwnerY
		OwnerLastMotion = OwnerMotion
		OwnerTargetLast = GetV(V_TARGET,MyOwner)
		MyTarget = GetV(V_TARGET,myid)

		--error(MyAttackRange)

		--OwnerTargetAtSpawn= GetV(V_TARGET,MyOwner)
		if (MyType == nil) then
			MyType= (GetV(V_MERTYPE,myid) + 16)
			if (MyType == 17) then
				MyType = MerTypeCheck()
			end
			HomunClass = 0
			Dt[myid]={MERCENARY,MERCENARYTARGET,0,0,0,0,0}
			VanUseChaotic = 0
			--LastMercID = MercID
			--if (BuffTimers[MyID] ~= nil) then
			--	Buff1 = BuffTimers[v][DEFENSETIMER]
			--	Buff2 = BuffTimers[v][OFFENSETIMER]
			--end
			--MercID = MyID
			--HelperID = HomunID
			--HelperPriority = HomunPriority
			--MyPriority = MercPriority
			if (ProvokeOwner > 0) then
				ProvokeOwner = PROVOKETARGET
			else
				ProvokeOwner = 0
			end

			if (SRecoveryOwner == 1) then
				Dt[MyOwner]={OWNERSTATUS,ProvokeOwner,OwnerMotion,OwnerX,OwnerY,0,0}
			else
				Dt[MyOwner]={OWNER,ProvokeOwner,OwnerMotion,OwnerX,OwnerY,0,0}
			end
			MyMercenary = MyID
			MercX,MercY = MyX,MyY
			MercenaryTargetLast = GetV(V_TARGET,myid)
			
		else
			if ( Dt[MyOwner]==nil) then
				Dt[MyOwner]={OWNER,0,OwnerMotion,OwnerX,OwnerY,0,0}
			end

			AFKCountDown = (AFKMaxTime * 60000)
			--error(AFKCountDown)

			AFKTimer = MySpawnTime + AFKCountDown
			HomunClass = -1 * modulo(MyType,4)
			if (HomunClass==0) then 
				HomunClass=VANILMIRTH
			end

			if (Dt[MyID] ~= nil and WriteActorInfo == 1) then
				LastTimer = Dt[MyID][TARGET_TIMER]
				if (MySpawnTime > LastTimer) then
					--error("spawntime " ..MySpawnTime.. " lastimer " ..LastTimer)
					BuffTimers[MyID] = {0,0}
					--WriteBuffTimers()
					--WriteDt()
				end
			end
			--Dt[MyID][TARGET_TIMER] = CurrentTick

			Buff1 = HomunBuff1
			Buff2 = HomunBuff2
			Dt[myid]={HOMUNCULUS,HOMUNCULUSTARGET,0,0,0,0,0}
			TraceAI("HomunClass" ..HomunClass.. "MyType" ..MyType)
			--HomunID = MyID
			--HelperID = MercID
			--HelperPriority = MercPriority
			--MyPriority = HomunPriority
			--MyHomunculus = MyID
			ISupportCast = 0
			MyHomunculus = MyID
			HomunX,HomunY = MyX,MyY
			HomunculusTargetLast = GetV(V_TARGET,myid)
		end

		if (BuffTimers[MyID] ~= nil) then
			Buff1 = BuffTimers[MyID][DEFENSETIMER]
			Buff2 = BuffTimers[MyID][OFFENSETIMER]
			AutoZerkOn = 1
			
		else
			Buff1 = 0
			Buff2 = 0
			AutoZerkOn = 0
			BuffTimers[MyID] = {0,0}
			WriteBuffTimers()
		end

		--Dt[0]={0,0,0,0,0,0,0}
		WriteDt()
		if (ISupportCast == 1) then
			CastTargetLast = GetV(V_TARGET,MyOwner)
		else
			CastTargetLast = 0
		end

		if (GetTick() < (MySpawnTime + SpawnWait)) then
			return
		end

		MoveToOwnerDest()
		Move(MyID,MyDestX,MyDestY)

		MyType = MyType * -1
		TraceAI(" My ID is " ..myid.. " Type: " ..MyType.. " Spawned: " ..MySpawnTime.. " MaxHp: " ..MyMaxHP.. " MaxSp: " ..MyMaxSP.. " Owner ID: " ..MyOwner.. " Attackrange: " ..MyAttackRange)
		
		if (AIDecideChase ==1) then
			if ((MyType <= MARCHER01 and MyType >= MLANCER06) or (MyType <= MSWORDMAN01 and MyType >= MSWORDMAN06)) then
				FollowChaseDown	=0
				MoveChaseDown	=0
			--else
			--	FollowChaseDown	=1
			--	MoveChaseDown	=1
			end
		end
		--MaxDistanceX = MaxDistance
		if (UseRecovery  == 1) then
			RecoverySkill,RecoverySp = GetRecoverySkill()
			 -- lvl1 skills. status detection attempted only for some. sitcheck for the rest.
		end
		if (UseQuicken  == 1) then
			QuickenSkill,QuickenLevel,QuickenSp,QuickenDuration = GetQuickenSkill()
		end
		if (UseDevotion == 1) then
			DevoLevel,DevoDuration = GetDevotionSkill() 
			--sp cost is always 25. skill=ML_DEVOTION
		end
		if (UseProvoke == 1) then
			ProvLevel,ProvSp = GetProvokeSkill() 
		--  duration always 30000, sp from 4-8, skill=MER_PROVOKE
		end
		if (AttemptDecloak == 1) then
			DecloakSkill,DecloakLevel,DecloakSp,DecloakMethod = GetDecloakSkill() 
		-- decloak behavior is skill specific. 
		end
		if (UseLimitBreak == 1) then
			LimitBreak = GetLimitBreak()
		end
		if (UseTraps == 1) then
			TrapSkill, TrapLevel, TrapSp = GetTrapSkill()
			--error(" TrapSkill, TrapLevel, TrapSp " ..TrapSkill.. "," ..TrapLevel.. "," ..TrapSp)
			--if (TrapFollowForm > 0 or TrapMoveForm > 0) then
				if (TrapSkill == MA_LANDMINE) then
					TrapLevel2 = 4
				else
					TrapLevel2 = TrapLevel
				end
			--end
		end
                 if (UseAOESkills == 1) then
                         AOESkill,AOELevel,AOESp,AOEMethod,AOERadius,AOERange = GetAOESkill()
                         --behavior, range, etc varies by skill
                 end
                 PushbackSkill = 0
                 PushbackSp = 0
                 PushbackDistance = PushbackDistance or 0
                 if (UsePushback == 1) then
                         PushbackSkill, PushbackLevel, PushbackSp,PushSkillRange = GetPushbackSkill()
                         --behavior varies by skill
                 end
                 if (UseDecAgi == 1) then
                         DecAgiLevel, DecAgiSp = GetDequickenSkill()
                         --skill=MER_DECAGI
                 end
		if (UseDivina == 1) then
			if (MyType~=MLANCER02) then
				UseDivina = 0
			else
				TraceAI("I will use Lex Divina")
			end
		
		end
		if (UseAtkSkills == 1) then
			AtkSkill,AtkSkillLevel,AtkSkillRange,AtkSkillSp,AtkSkillDelay=GetAtkSkill()
			--regular atk skills. range on spiral pierce, caprice...
		end
		if (UseDefender == 1) then
			if (MyType==MLANCER09) then
				UseDefender = 1
			else
				UseDefender = 0
			end
		end
		if (UseDefenseSkill == 1) then
			DefenseSkill, DefenseLevel, DefenseSp, DefenseDuration =GetDefenseSkill()
			--guard, reflect shield, parrying, filir flee, amistr def
		end
		if (UseBerserk == 1) then
			BerserkSkill=GetBerserkSkill()
			--frenzy, autozerk. use when hp low.
		end
		if (UseCrash == 1) then
			CrashLevel=GetCrashLevel()
			--crash sucks. don't even feel like putting it in.
		end
		if (UseRescueSkill == 1) then
			RescueSkill,RescueLevel,RescueSp=GetRescueSkill()
			--error("skill, lvl, sp:" ..RescueSkill.."," ..RescueLevel.."," ..RescueSp)
			--scapegoat, lif heal, castling... use when owner hp low
		end
		if (VanCapriceLvl == 0) then
			DmgCheckTarget2 = -2
		end
		if (UseMagni == 1) then
			if (MyType~=MARCHER04) then
				UseMagni = 0
			end
		end
		if ( TrapSkill == 0) then
			TrapFollowForm = 0
			TrapMoveForm = 0
		end
		if (TrapMoveForm >= 6) then
			TrapMoveForm = 0
		end
		if (TrapFollowForm >= 5) then
			TrapMoveForm = 0
		end
		OneTimeCheck = 0
		--SkillObject(MyID,3,HVAN_SELFDESTRUCT,2064385)
		--error("ismonster " ..IsMonster(2045807))
		--ActorFile = io.open("AI_xatiya/ActorList.lua", "w")
	end
	if (WriteActorInfo == 1) then
		dofile ("AI_xatiya/ActorList.txt")
	end
----------------------------------------------------------------------------------------------------------------------------
--refreshed every cycle
	UsedSkill = 0
	MyX,MyY = GetV(V_POSITION,myid)
	MyMotion = GetV(V_MOTION,myid)
	MyTarget = GetV(V_TARGET,myid)
	MyHP=GetV(V_HP,myid)
	MySP=GetV(V_SP,myid)
	MyHPPercent=100*MyHP/MyMaxHP
	MySPPercent=100*MySP/MyMaxSP
	OwnerX, OwnerY = GetV(V_POSITION,MyOwner)
	OwnerMotion = GetV(V_MOTION,MyOwner)
	--OwnerTarget = GetV(V_TARGET,MyOwner)
	OwnerMaxHP=GetV(V_MAXHP,MyOwner)
	OwnerMaxSP=GetV(V_MAXSP,MyOwner)
	OwnerHP=GetV(V_HP,MyOwner)
	OwnerSP=GetV(V_SP,MyOwner)
	OwnerHPPercent=100*OwnerHP/OwnerMaxHP
	OwnerSPPercent=100*OwnerSP/OwnerMaxSP
	MyDistance=GetDistance(MyX,MyY,OwnerX,OwnerY)
	CurrentTick = GetTick()
	TraceAI("My position is " ..MyX.. "," ..MyY.. " Target: " ..MyTarget.. " Motion: " ..MyMotion.. " HP,SP: " ..MyHP.. "," ..MySP.. " HP Percent: " ..MyHPPercent.. " SP Percent " ..MySPPercent)	
	TraceAI("Owner position is " ..OwnerX.. "," ..OwnerY.. " Distance: " ..MyDistance.. " Target: " ..OwnerTarget.. " Motion: " ..OwnerMotion.. " HP,SP: " ..OwnerHP.. "," ..OwnerSP.. " MaxHP,MaxSP: " ..OwnerMaxHP.. ","..OwnerMaxSP)

	
	--Enemy1Motion = GetV(V_MOTION,MyEnemy)
	--Enemy2Motion = GetV(V_MOTION,MyEnemy2)
	--Enemy2X,Enemy2Y = GetV(V_POSITION,MyEnemy2)
	--Enemy2Distance = GetDistance(MyX,MyY,Enemy2X,Enemy2Y)
	--HelperX,HelperY= GetV(V_POSITION,HelperID)
	--HelperTarget = GetV(V_TARGET,HelperID)
	--TraceAI("Enemy1 motion: " ..MyEnemy.. " Enemy2 motion: " ..MyEnemy2)

	--TraceAI("myid is " ..MyID.. " HelperID: " ..HelperID.. " helpertarget is " ..HelperTarget)

	UsedAttack = 0
	if (MyDistance > MaxDistance) then
		Move(MyID,OwnerX,OwnerY)
		MyState = FOLLOW_ST
		UsedSkill = 1
		UsedAttack = 1
		JustSkilled = 1
		ChaseCheckList = nil
		--if (ChaseCheckList[ChaseTarget] ~= nil) then
		--	ChaseCheckList[ChaseTarget] = nil
		--end
		ChaseTarget = 0
		--TraceAI("Too far, moving to owner")
	end
	if (MyHomunculus ~= 0) then
		--error("homun helper detected")
		HomunX,HomunY = GetV(V_POSITION,MyHomunculus)
	end
	if (MyMercenary ~= 0) then
		MercX,MercY = GetV(V_POSITION,MyMercenary)
	end
	--if (MercenaryTarget ~= (-1 * GetV(V_TARGET,MyMercenary))) then
	--	MercenaryTarget = GetV(V_TARGET,MyMercenary)
	--else
		--error("went negative")
	--end

			--if ((MercenaryTarget * -1) ~= GetV(V_TARGET,MyMercenary)) then
				MercenaryTarget = GetV(V_TARGET,MyMercenary)
			--end
			--if ((HomunculusTarget * -1) ~= GetV(V_TARGET,MyHomunculus)) then
				HomunculusTarget = GetV(V_TARGET,MyHomunculus)
			--end
			--if ((OwnerTarget * -1) ~= GetV(V_TARGET,MyOwner)) then
				OwnerTarget = GetV(V_TARGET,MyOwner)
				--error(OwnerTarget)
			--else
				--if (OwnerTarget ~= 0) then
					--error("it worked")
				--end
			--end
			--TraceAI("OwnerTarget is: " ..OwnerTarget)




--currently impossible to remove trap using AI.
--instead of using skill directly, set as recovery target?
--what about testing based on enemy distance? some skills exceed attackrange. what if you want to keep target and move to it?
	--if (MyEnemy ~= 0) then
	--	if (Enemy1Motion == MOTION_SIT or Enemy1Motion == MOTION_DEAD or Enemy1Motion == MOTION_SLEEP or Enemy1Motion == MOTION_COUNTER) then
	--		MyEnemy = 0
	--	end
	--end
	--if (MyEnemy2 ~= 0) then
	--	if (Enemy2Motion == MOTION_SIT or Enemy2Motion == MOTION_DEAD or Enemy2Motion == MOTION_SLEEP or Enemy2Motion == MOTION_COUNTER) then
	--		MyEnemy2 = 0
	--	elseif (Enemy2Distance > MyAttackRange) then
	--		MyEnemy2 = 0
	--	end
	--end
--=======================================================================================================
--	reset some lists every cycle.
--	statused = {} -- do not reset this one every cycle
--	trapbait = {}
	RecoveryPriority = 15
	DecloakPriority = -20
	CastBreakPriority = 0
	SilencePriority = 0
	PushbackPriority = 0
	CrashPriority= 0
	TrapPriority = 0
	DecAgiAlliance = 0
	NormAtkPriority = 0
	NormAtkTarget = 0
	PushbackX = 0
	SleepTarget = 0	
	AOEX		= 0
	AtkSkillPriority = 0
	TrapTarget	= 0
	ScreenEnemies = {}
	ScreenNeutrals = {}
	FrozenEnemies = {}
	FrozenCount = 0
	NeutralCount = 0
	EnemyCount = 0
	ProvokeBuffTarget = 0
	--Singer = 0
	SongMakers = {}
	DanceMakers = {}
	KiteEnemies = {}
	KiteTarget = 0
	AtkSkillTarget = 0
	CastBreakTarget = 0
	LimitBreakTarget = 0
	LimitBreakCount = 0
	CastBreakSkill = 0

	if(SongTimer < CurrentTick) then
		SongBuffed = 0
	end
	if(DanceTimer < CurrentTick) then
		DanceBuffed = 0
	end

	for v,i in pairs(Monsters) do
		Monsters[v] = 0
	end




	actors = GetActors ()				
	for i,v in ipairs(actors) do


		--if (v~=MyID and v~=MyOwner and v~=MyHomunculus) then 
		vMotion = GetV(V_MOTION,v)
		if (MiscTimer < CurrentTick and (vMotion == 14 or vMotion == 15 or vMotion == 29 or vMotion >= 42)) then
			MiscTimer = CurrentTick + 86400000
			WriteBuffTimers()
			if (HomunClass ~= 0) then
				vMobType = GetV(V_HOMUNTYPE, v)
				error(" actor " ..v.. " classtype " ..vMobType.. " did unknown motion: " ..vMotion.. " contact Pathoth")
			else
				error(" actor " ..v.. " did unknown motion: " ..vMotion.. " contact Pathoth")
			end
		end
vX, vY = GetV (V_POSITION,v)
vDistance = GetDistance(MyX, MyY, vX, vY)
vOwnerDistance = GetDistance(OwnerX, OwnerY, vX, vY)
if (MercX > 0) then
vMercDistance = GetDistance(MercX,MercY,vX,vY)
else
vMercDistance = 30
end
if (HomunX > 0) then
vHomunDistance = GetDistance(HomunX,HomunY,vX,vY)
else
vHomunDistance = 30
end
	
		if (Dt[v]~= nil) then
			vAlliance = Dt[v][TARGET_ALLIANCE]
			vType = Dt[v][TARGET_TYPE]
			vLastMotion = Dt[v][TARGET_LMOTION]
			vLastX = Dt[v][TARGET_LASTX]
			vLastY = Dt[v][TARGET_LASTY]
			vStatus = Dt[v][TARGET_STATUS]
			vTimer = Dt[v][TARGET_TIMER]
		else
			vAlliance = NEUTRAL
			vType = NONE
			vLastMotion = -1
			vLastX = 0
			vLastY = 0
			vStatus = NONE
			vTimer = 0
		end

		if (vMotion == MOTION_SING) then
			--if (HomunClass ==0 and vType == 0) then
				--vType = Preset[CLOWN]
			--end
			if (vDistance <= 3) then
				SongBuffed = 1
				SongTimer = CurrentTick + 19000
			else
				SongMakers[v] = vDistance
			end
		end

		if (vMotion == MOTION_DANCE) then
			--if (HomunClass ==0 and vType == 0) then
			--	--vType = Preset[GYPSY]
			--end
			if (vDistance <= 3) then
				DanceBuffed = 1
				DanceTimer = CurrentTick + 19000
			--elseif ( vAlliance >= OWNER and vAlliance <= ALLY ) then
			else
				DanceMakers[v] = vDistance
			end
		end
		--if (v < -1 ) then
			--Dt[(v * -1)]= nil
			--if (v == (MercenaryTarget * -1) and MercenaryTarget > 0) then
			--	MercenaryTarget = MercenaryTarget * -1
			--end
			--if (v == (HomunculusTarget * -1) and HomunculusTarget > 0) then
			--	HomunculusTarget = HomunculusTarget * -1
			--end
			--if (v == (OwnerTarget * -1) and OwnerTarget > 0) then
			--	error("ownernegativetarget")
			--	OwnerTarget = OwnerTarget * -1
			--end
		--end
		--if (v < -1) then
			--error("uhh" ..v)
		--end
		if (vMotion ~= MOTION_DEAD) then
			if (AtkDLP == 1) then
				if ( vType == DLPTARGET) then
					if (vDistance <= MyAttackRange) then
						if (NormAtkPriority < vAlliance) then
							NormAtkTarget = v
							NormAtkPriority = vPriority
						end
					end
				end
			end
			if ( vType == PROVOKETARGET and ProvLevel ~= 0 and MySP >= ProvSp and vTimer < CurrentTick) then
				if (vDistance <= 10) then
					ProvokeBuffTarget = v
end
				end
			end

		--vMobType = GetV(V_HOMUNTYPE, v)
		--if (vMobType == 1142 and vType == IGNORETARGET) then
		--	error("success?")
		--end


---
		if (vMotion ~= MOTION_DEAD and v ~= MyID and v > -1 and vType ~= IGNORETARGET and SuperPassive == 0) then
			vTarget = GetV(V_TARGET,v)
			--vTargetable = IsMonster(v)
			--vEnemyMotion = GetV(V_MOTION,vTarget)
			--if (HelperX ~= -1) then
			--	vHelperDistance = GetDistance(HelperX, HelperY, vX, vY)
			--else
			--	vHelperDistance = 0
			--end
			if (Dt[vTarget]~= nil) then
				vEnemyAlliance = Dt[vTarget][TARGET_ALLIANCE]
				vEnemyType = Dt[vTarget][TARGET_TYPE]
			else
				vEnemyAlliance = NEUTRAL
				vEnemyType = NONE
			end
			--if (vMotion == MOTION_DEAD) then
			--	Dt[v][TARGET_STATUS] = NONE
			--break
			--end
TraceAI(v.. " position is " ..vX.. "," ..vY.. " Target: " ..vTarget.. " Motion: " ..vMotion)	
--------------------------------------------------------------------------------------------Mobtype + Presets
			--TraceAI("HomunClass is " ..HomunClass)
			if (HomunClass ~= 0) then
				if (vType == NONE) then
					vMobType = GetV(V_HOMUNTYPE, v)
					if (v > NpcActorNumber) then
						if (vMobType < 150 ) then
							vMobType = vMobType * -1
						end
					end
					vPreset = Preset[vMobType]
					if (vPreset ~= nil) then
						TraceAI(v.. "Preset is" ..vPreset)
						vType = vPreset
						if (vType == SUMMONTARGET) then
							vAlliance = ALLY
						end
						if (vType == PASSIVETARGET) then
							vAlliance = ALLY
						end
						if (vType == MVPTARGET) then
							Eclipse()
							vType = TANKKITETARGET
						end
					end
					--if (vMobType == 1725 or vMobType == 1973) then
					--	error ("mobtype " ..vMobType)
					--end
				end
			else
				if (vType == NONE) then
					vMerType=GetV(V_MERTYPE,v)
					if (vMerType > 1) then
						vType = MERCENARYTARGET
					end
				end
			end
-----
			--if (v > NpcActorNumber and vTarget < NpcActorNumber) then
				--ignore. KS detection.
			--end
			if (vType == TANKTARGET) then
				vAlliance = ENEMYPRIORITY
			end
			if (vType == IGNORETARGET) then
				vAlliance = IGNORE
			end
------------------------------------------------------------------------------------------------Status Recovery and summon provoke
			if (vType ~= IGNORETARGET) then
				if (RecoverySkill ~= 0) then
					if (vAlliance == OWNERSTATUS or vAlliance == ALLYSTATUS) then
						if ((RecoverySkill == MER_TENDER or (RecoverySkill == MER_REGAIN and UseStunRecovery == 1)) and UseTimerRecovery == 1) then
							if (vMotion == vLastMotion and vMotion ~= MOTION_MOVE and vMotion ~= MOTION_SIT) then
								--if (vMotion ~= MOTION_MOVE and vMotion ~= MOTION_SIT) then
									if (vTimer < CurrentTick) then
										RecoverySetTarget(v)
										--RecoveryAlliance = vAlliance
									end
								--end
							else
								vTimer = CurrentTick + RecoveryTimer
							end
						end
					end
					if (vAlliance >= OWNER and vAlliance <= ALLY) then
						--error("sleep")
						if (RecoverySkill == MA_REMOVETRAP) then
							TraceAI("remove trap...")
							--doesnt work. AI can't use remove trap?
						elseif (RecoverySkill ~= MER_REGAIN) then
							if (vMotion == MOTION_SIT or (vTimer == 0 and v == MyOwner)) then
								if (vTimer < CurrentTick) then
									RecoverySetTarget(v)
									--RecoveryAlliance = vAlliance
								end
							end
						else
							if (vMotion == MOTION_SLEEP) then
								RecoverySetTarget(v)
								
							end
						end
						
					end
				end
			end
			if (vType == SUMMONTARGET and ProvLevel ~= 0 and MySP >= ProvSp and vTimer < CurrentTick) then
				ProvokeBuffTarget = v
			end
--------------------------------------------------------------------------------------------------Decloaking
			if (vX == -1) then
				if (vAlliance >= ENEMY or vAlliance == NONE) then
					if (DecloakSkill ~= 0) then
					--TraceAI("decloak v is" ..v)
						if ( vLastX ~= -1) then						
						--if (vAlliance >= ENEMY or vAlliance == NONE) then
							vDistance = GetDistance(MyX, MyY, vLastX, vLastY)
							vPriority = vAlliance + (15 - vDistance)
							if (MyType==MARCHER07 and vDistance <=5) then
								if (vDistance <=4) then
									if (DecloakPriority < vPriority -1) then
										DecloakTarget = v
										DecloakPriority = vPriority -1
										DecloakX,DecloakY = vLastX,vLastY
										Decloak2Skill = MA_FREEZINGTRAP
										Decloak2Sp = 10
										Decloak2Level = 3
										Decloak2Method = 2
									end
								else
									if (DecloakPriority < vPriority -2) then
										DecloakTarget = v
										DecloakPriority = vPriority -2
										DecloakX,DecloakY = Closer(MyX,MyY,vLastX,vLastY)
										Decloak2Skill = MA_FREEZINGTRAP
										Decloak2Sp = 10
										Decloak2Level = 3
										Decloak2Method = 2
									end
								end
							elseif (MyType==MARCHER02 and vDistance <=3 and Buff2 < CurrentTick) then
								--if (vAlliance >= ENEMY) then
									if (DecloakPriority < vPriority) then
										DecloakTarget = v
										DecloakPriority = vPriority 
										DecloakX,DecloakY = vLastX,vLastY
										Decloak2Skill = MER_SIGHT
										Decloak2Sp = 10
										Decloak2Level = 1
										Decloak2Method = 0
									end
								--end
							else
								Decloak2Skill = DecloakSkill
								Decloak2Method = DecloakMethod
								Decloak2Sp = DecloakSp
								Decloak2Level = DecloakLevel
							end
							if (Decloak2Skill==MA_SHOWER) then
								if (vDistance <=11) then
									if (DecloakPriority < vPriority -2) then
										DecloakTarget = v
										DecloakPriority = vPriority -2
										DecloakX,DecloakY = vLastX,vLastY
									end
								elseif (vDistance <=12) then
									if (DecloakPriority < vPriority -3) then
										DecloakTarget = v
										DecloakPriority = vPriority -3
										DecloakX,DecloakY = Closer(MyX,MyY,vLastX,vLastY)
									end
								elseif (vDistance <=13) then
									if (DecloakPriority < vPriority -4) then
										DecloakTarget = v
										DecloakPriority = vPriority -4
										DecloakX,DecloakY = Closest(MyX,MyY,vLastX,vLastY)
									end
								end
							elseif (Decloak2Skill==MA_SANDMAN) then
								if (vDistance <=4) then
									if (DecloakPriority < vPriority -1) then
										DecloakTarget = v
										DecloakPriority = vPriority -1
										DecloakX,DecloakY = vLastX,vLastY
									end
								elseif (vDistance ==5) then
									if (DecloakPriority < vPriority -2) then
										DecloakTarget = v
										DecloakPriority = vPriority -2
										DecloakX,DecloakY = Closer(MyX,MyY,vLastX,vLastY)
									end
								elseif (vDistance ==6) then
									if (DecloakPriority < vPriority -3) then
										DecloakTarget = v
										DecloakPriority = vPriority -3
										DecloakX,DecloakY = Closest(MyX,MyY,vLastX,vLastY)
									end
								end
							elseif (Decloak2Skill==MA_LANDMINE and vDistance <=4) then
								--error("here")
								if (DecloakPriority < vPriority) then
									--error("here")
									DecloakTarget = v
									DecloakPriority = vPriority 
									DecloakX,DecloakY = vLastX,vLastY
								end
							elseif (Decloak2Skill==MS_MAGNUM and vDistance <=2) then
								if (DecloakPriority < vPriority) then
									DecloakTarget = v
									DecloakPriority = vPriority 
									DecloakX,DecloakY = vLastX,vLastY
								end
							end
--					
							--if (vStatus ~= CLOAKED) then
							--	vStatus = CLOAKED
							--	vTimer = (CurrentTick + 1000)
							--elseif (vTimer >= CurrentTick) then
							--	vLastX = -1
							--end
						end
					end
					if (vStatus ~= CLOAKED) then
						vStatus = CLOAKED
						vTimer = (CurrentTick + 1000)
					elseif (vTimer >= CurrentTick) then
						vLastX = -1
					end
				end
			else
				vLastX = vX
				vLastY = vY
				if (vStatus == CLOAKED) then
					vStatus = CLOAKER
					vTimer = CurrentTick +2000
				end
			end
------------------------------------------------------------------------------------------------Enemy/Ally alliance analysis
if (v > NpcActorNumber) then
if (vAlliance == HOMUNCULUS) then
if (vType == 0) then
MyHomunculus = v
HomunculusTargetLast = vTarget
end
if ( Dt[vTarget] ~= nil ) then
Dt[vTarget][TARGET_ALLIANCE] = ENEMY
end
elseif (vAlliance == MERCENARY) then
if (vType == 0) then
MyMercenary = v
MercenaryTargetLast = vTarget
end
if ( Dt[vTarget] ~= nil ) then
Dt[vTarget][TARGET_ALLIANCE] = ENEMY
end
else
Monsters[v] = 1
end
end
			
			if (vMotion ~= MOTION_SIT and v > 0) then
				if (vTarget > NpcActorNumber and vEnemyAlliance == NEUTRAL) then
					--if ( Dt[vTarget] ~= nil and vAlliance ~= HOMUNCULUS and vAlliance ~= MERCENARY) then
					if ( Dt[vTarget] ~= nil ) then
						Dt[vTarget][TARGET_ALLIANCE] = ALLY
					end
				end
				--if (v > NpcActorNumber and vEnemyAlliance
				if (vAlliance == NEUTRAL or vAlliance == ALLY) then		
					--if (vEnemyAlliance == HOMUNCULUS) then  
					--	vAlliance = ENEMY				-- homun cannot be targeted by support skills
					--end
					if (HomunculusTarget == v and HomunculusTarget ~= HomunculusTargetLast) then
						vAlliance = ENEMY
					end
					if (MercenaryTarget == v and MercenaryTarget ~= MercenaryTargetLast ) then
						vAlliance = ENEMY
					end
					if (OwnerTarget == v and OwnerTarget ~= OwnerTargetLast) then
						if (OwnerMotion == MOTION_CASTING) then
							if (ISupportCast == 0) then
								vAlliance=ENEMY
							else
								CastTargetLast = OwnerTarget
							end
						elseif (CastTargetLast ~= OwnerTarget) then 
							vAlliance=ENEMY
						elseif (OwnerMotion == MOTION_TOSS or OwnerMotion == MOTION_ATTACK or OwnerMotion == MOTION_VULCAN or OwnerMotion == MOTION_SPIRAL or OwnerMotion == MOTION_SHARPSHOOT or OwnerMotion == MOTION_FLYK) then
							CastTargetLast = 0
						end
					end
					if (vEnemyAlliance >= OWNER and vEnemyAlliance <=ALLYPROTECT) then
						if (v > NpcActorNumber) then
							if (vType ~= SUMMONTARGET) then
								vAlliance = ENEMY
							end
						elseif (vType ~= NONE and vType ~= SUPPORTTARGET and vType ~= QUICKEN2TARGET and vType ~= SUPPORT2TARGET and vType ~= SUPPORT3TARGET) then
							vAlliance=ENEMY
							--error("beep")
						elseif (vMotion == MOTION_ATTACK or vMotion == MOTION_VULCAN or vMotion == MOTION_SPIRAL or vMotion == MOTION_SHARPSHOOT or vMotion == MOTION_FLYK) then
							vAlliance=ENEMY
						end 
					end
				end

--------------------------------------------------------------------------------------------------enemy priority	
				if (vX ~= -1 and vAlliance >= ENEMY) then
					vPriority = vType + vAlliance + ((30 - vHomunDistance) * HomunPriority) + ((30 - vOwnerDistance) * OwnerPriority) + ((30 - vMercDistance) * MercPriority)
					if(vStatus == CLOAKER) then
						vPriority = vPriority + 40
						if (vTimer < CurrentTick) then
							vStatus = NONE
						end
					end
					if (vTarget == MyOwner) then
						vPriority = vPriority + OwnerPriority 
					elseif (vTarget == MyHomunculus) then
						vPriority = vPriority + HomunPriority 
					elseif (vTarget == MyMercenary) then
						vPriority = vPriority + MercPriority 
					elseif (vEnemyAlliance >= OWNER and vEnemyAlliance <=ALLYPROTECT) then
						vPriority = vPriority + FriendPriority	
					end
					if (OwnerTarget == v ) then
						vPriority = vPriority + 7 + (OwnerPriority *2)
					end
					if (MercenaryTarget == v) then
						vPriority = vPriority + 7 + (MercPriority *2)
					end
					if (HomunculusTarget == v) then
						vPriority = vPriority + 7 + (HomunPriority *2)
					end

----------------------------------------------------------------------------------------------enemy list, status analysis

					if(TrapSkill ~= 0) then
						if (vStatus==FROZEN) then
							if (vTimer < CurrentTick) then
								if ((TrapSkill==MA_FREEZINGTRAP) and (vMotion ~= MOTION_DAMAGE)) then
									vStatus=NONE
								elseif ((TrapSkill==MA_SANDMAN) and (vMotion ~= MOTION_SLEEP)) then
									vStatus=NONE
								end	
							end
						end
					end

					if (vDistance <= MyAttackRange and vMotion ~= MOTION_SLEEP and vStatus ~= FROZEN) then
						if (((TrapSkill == MA_SANDMAN and vDistance <= 6) or (TrapSkill == MA_FREEZINGTRAP and vDistance <= 5)) and (vType ~= NOSKILLTARGET)) then
						else
							if (NormAtkPriority < vPriority) then
								TraceAI("atk target " ..v.. " set")
								NormAtkTarget = v
								NormAtkPriority = vPriority
							end
						end
					end
					if (vType ~= NOSKILLTARGET and vType ~= TANKTARGET) then
						--if(TrapSkill ~= 0) then
						--	if (vStatus==FROZEN) then
						--		if (vTimer < CurrentTick) then
						--			if ((TrapSkill==MA_FREEZINGTRAP) and (vMotion ~= MOTION_DAMAGE)) then
						--				vStatus=NONE
						--			elseif ((TrapSkill==MA_SANDMAN) and (vMotion ~= MOTION_SLEEP)) then
						--				vStatus=NONE
						--			end	
						--		end
						--	end
						--end

						if (UseDivina == 1) then
							if (vStatus==SILENCED) then
								if ((vTimer < CurrentTick or vMotion>=MOTION_SPIRAL or vMotion == MOTION_VULCAN or vMotion==MOTION_SKILL or vMotion == MOTION_CASTING or vX == -1) and vLastMotion~=vMotion) then
									vStatus = NONE
								end
							end
							if (MySP >= 20 and MyMotion ~= MOTION_CASTING and vStatus ~= SILENCED and vDistance <=10) then
								if (vType == CASTERTARGET) then
									if (SilencePriority < vPriority + 40) then
										SilenceTarget = v
										SilencePriority = vPriority +40
									end
								elseif (vType == NONE) then
									if (SilencePriority < vPriority ) then
										SilenceTarget = v
										SilencePriority = vPriority
									end
								end		
							end
						end		

						if (DecAgiLevel ~= 0) then
							if (vStatus==SLOWED) then
								if (vTimer < CurrentTick) then
									vStatus = NONE
								end
							end
							if (MySP >= DecAgiSp and MyMotion ~= MOTION_CASTING and vDistance <=10 and CurrentTick > SkillDelayTimer) then
								if (vType == QUICKENTARGET or QUICKEN2TARGET) then
									if (DecAgiAlliance < vPriority -1) then
										DecAgiTarget = v
										DecAgiAlliance = vPriority -1
									end
								elseif (vType == NONE) then
									if (vStatus ~= SLOWED) then
										if (DecAgiAlliance < vPriority -20 ) then
											DecAgiTarget = v
											DecAgiAlliance = vPriority -20
										end
									end
								end
							end
						end			

-------------------------------------------------------------------------------------------Attack moves
						if (KiteHostiles ==1 and (vType == KITETARGET or (vType == TANKKITETARGET and vTarget == MyID) or KiteAllEnemies == 1)) then
							KiteTarget = 1
							if (vDistance < KiteDistance) then
								KiteTarget = 2
								KiteEnemies[v] = vDistance
							end
							--error("beep")
						end

						if (vMotion ~= MOTION_SLEEP and vStatus ~= FROZEN and v > 0) then
							EnemyCount = EnemyCount +1
							ScreenEnemies[v] = vPriority
						if (MyMotion ~= MOTION_CASTING and CurrentTick > SkillDelayTimer) then
							--EnemyCount = EnemyCount +1
							--ScreenEnemies[v] = vPriority
							if (vType == EMPBREAKTARGET and LimitBreak == HFLI_SBR44 and vEnemyType == NOSKILLTARGET and vDistance <= 2) then
								if ( GetV(V_HOMUNTYPE, vTarget) == 1288) then -- (1288 is emperium)
									--error("sbr44")
									LimitBreakTarget = v
								end
							end
							if (vMotion == MOTION_CASTING or vMotion == MOTION_NINJACAST) then
								if (vDistance <= MyAttackRange) then
									--if (v ~= LastSleepTarget) then
										if (CastBreakPriority < vPriority) then
											CastBreakTarget = v
											CastBreakPriority = vPriority
											CastBreakSkill = 0
										end
									--end
								elseif (ProvLevel ~= 0 and MySP >= ProvSp and vType == CASTERTARGET) then
									if (vDistance <= 10) then
										if (CastBreakPriority < vPriority -2) then
											CastBreakTarget = v
											CastBreakPriority = vPriority -2
											CastBreakSkill = MER_PROVOKE
										end
									end

								elseif (HomunClass == VANILMIRTH and MySP >= AtkSkillSp) then
									if (vDistance <= 10) then
										if (CastBreakPriority < vPriority -2) then
											CastBreakTarget = v
											CastBreakPriority = vPriority -2
											CastBreakSkill = HVAN_CAPRICE
										end
									end
								elseif ((MyType==MARCHER07 or MyType==MARCHER02) and MySP >= 15) then
									if (vDistance <= 13) then
										if (CastBreakPriority < vPriority -2) then
											--CastBreakTarget = v
											CastBreakPriority = vPriority -2
											CastBreakSkill = MA_SHOWER
											CastBreakX,CastBreakY = Closest(MyX,MyY,vX,vY)
										end
									end
								end
							end
--condense this, and add pushback range variable.
                                                        if (UsePushback == 1 and PushbackSkill ~= 0 and PushbackDistance ~= nil and PushbackSp ~= nil and vDistance <= PushbackDistance and MySP >= PushbackSp) then
                                                                if (PushbackSkill == MA_SHOWER) then
                                                                        if (vDistance <= 13) then
                                                                                Icebreaker = 0
                                                                                if (LastFrozenEnemies ~= nil) then
											for l,p in ipairs(LastFrozenEnemies) do
												pX, pY = GetV (V_POSITION,p)
												if(GetDistance(qX, qY, pX, pY) <= 1) then
													Icebreaker = 1
													break
												end
											end
										end
										if (PushbackPriority < vPriority and Icebreaker == 0) then
											PushbackPriority = vPriority
											PushbackX,PushbackY = Closest(MyX,MyY,vX,vY)
										end
									end
								elseif (PushbackSkill == MA_SKIDTRAP) then
									if (vDistance <= 4) then
										if (CurrentTick < CurrentTick or PushbackX ~= vX or PushbackY ~= vY) then
											if (PushbackPriority < vPriority) then
												PushbackPriority = vPriority
												PushbackX,PushbackY = vX,vY
											end
										end
									end
								elseif (vDistance <=PushSkillRange) then
									if (PushbackPriority < vPriority) then
										PushbackPriority = vPriority
										PushbackTarget = v
									end
								end
							end
		
							if (TrapSkill ~=0 and MySP >= TrapSp) then
								if (TrapSkill==MA_LANDMINE) then
									if (vDistance <= 4) then
										if ((Trap1Delay < CurrentTick or Trap1X ~= vX or Trap1Y ~= vY) and (Trap2Delay < CurrentTick or Trap2X ~= vX or Trap2Y ~= vY) and (Trap3Delay < CurrentTick or Trap3X ~= vX or Trap3Y ~= vY)) then
											if (TrapPriority < vPriority) then
												TrapPriority = vPriority
												TrapX,TrapY = vX,vY
											end
										end
									end
								elseif (TrapSkill==MA_FREEZINGTRAP) then
									if (vDistance <= 4) then
										if ((Trap1Delay < CurrentTick or Trap1X ~= vX or Trap1Y ~= vY) and (Trap2Delay < CurrentTick or Trap2X ~= vX or Trap2Y ~= vY) and (Trap3Delay < CurrentTick or Trap3X ~= vX or Trap3Y ~= vY)) then
											Icebreaker = 0
											if (LastFrozenEnemies ~= nil) then
												for l,p in ipairs(LastFrozenEnemies) do
													pX, pY = GetV (V_POSITION,p)
													if(GetDistance(vX, vY, pX, pY) <= 1) then
														Icebreaker = 1
														break
													end
												end
											end
											if (TrapPriority < vPriority and Icebreaker == 0) then
												TrapPriority = vPriority
												TrapX,TrapY = vX,vY
												TrapTarget = v
											end
										end
									end

									if (vDistance <= 5) then
										qX,qY = Closer(MyX,MyY,vX,vY)
										if ((Trap1Delay < CurrentTick or Trap1X ~= qX or Trap1Y ~= qY) and (Trap2Delay < CurrentTick or Trap2X ~= qX or Trap2Y ~= qY) and (Trap3Delay < CurrentTick or Trap3X ~= qX or Trap3Y ~= qY)) then
											Icebreaker = 0
											if (LastFrozenEnemies ~= nil) then
												for l,p in ipairs(LastFrozenEnemies) do
													pX, pY = GetV (V_POSITION,p)
													if(GetDistance(qX, qY, pX, pY) <= 1) then
														Icebreaker = 1
														break
													end
												end
											end
											if (TrapPriority < vPriority and Icebreaker == 0) then
												TrapPriority = vPriority
												TrapTarget = v
												TrapX,TrapY = qX,qY
											end
										end
									end
								elseif (TrapSkill==MA_SANDMAN) then
									if (vDistance <= 4) then
										if ((Trap1Delay < CurrentTick or Trap1X ~= vX or Trap1Y ~= vY) and (Trap2Delay < CurrentTick or Trap2X ~= vX or Trap2Y ~= vY) and (Trap3Delay < CurrentTick or Trap3X ~= vX or Trap3Y ~= vY)) then
											if (TrapPriority < vPriority) then
												TrapPriority = vPriority
												TrapX,TrapY = vX,vY
												TrapTarget = v
											end
										end
									end
									if (vDistance <= 5) then
										qX,qY = Closer(MyX,MyY,vX,vY)
										if ((Trap1Delay < CurrentTick or Trap1X ~= qX or Trap1Y ~= qY) and (Trap2Delay < CurrentTick or Trap2X ~= qX or Trap2Y ~= qY) and (Trap3Delay < CurrentTick or Trap3X ~= qX or Trap3Y ~= qY)) then
											if (TrapPriority < vPriority) then
												TrapPriority = vPriority
												TrapX,TrapY = qX,qY
												TrapTarget = v
											end
										end
									end
									if (vDistance <= 6) then
										qX,qY = Closest(MyX,MyY,vX,vY)
										if ((Trap1Delay < CurrentTick or Trap1X ~= qX or Trap1Y ~= qY) and (Trap2Delay < CurrentTick or Trap2X ~= qX or Trap2Y ~= qY) and (Trap3Delay < CurrentTick or Trap3X ~= qX or Trap3Y ~= qY)) then
											if (TrapPriority < vPriority) then
												TrapPriority = vPriority
												TrapX,TrapY = qX,qY
												TrapTarget = v
											end
										end
									end
								end
							end
							if (AtkSkill ~= 0 and MySP >= AtkSkillSp) then
								if (vDistance <= AtkSkillRange) then
									if (AtkSkillPriority < vPriority) then
										AtkSkillPriority = vPriority
										AtkSkillTarget = v
									end
								end
							end
						end
						end
					else
						FrozenCount = FrozenCount + 1
						FrozenEnemies[FrozenCount] = v
					end
				elseif (vAlliance == NEUTRAL and IsMonster(v)==1 and (vTarget == 0 or v < NpcActorNumber)) then
				--elseif (vAlliance == NEUTRAL and IsMonster(v)==1) then
					--if (v ~= HomunculusTargetLast and v ~= MercenaryTargetLast and v ~= OwnerTargetLast) then
						NeutralCount = NeutralCount +1
						--ScreenNeutrals[v] = vPriority
						ScreenNeutrals[v] = vDistance
					--end
				end
				if (vDistance <= 4 and v < NpcActorNumber) then
				--if (vDistance <= 4 ) then 	-- use vanil bioexplode vs monsters? what a waste!
					if (vAlliance == ENEMY) then
						LimitBreakCount = LimitBreakCount + 1
					elseif (vAlliance == ALLY) then
						LimitBreakCount = LimitBreakCount - 2
					end
				end
			end
		else
			if (vType == IGNORETARGET) then
				Monsters[v] = 1
			end
			vStatus = 0
		end	
	--TraceAI("ActorData for " ..v.. " Alliance: " ..vAlliance.. " Type: " ..vType.. " Motion: " ..vMotion.. " vX,vY: " ..vX.. "," ..vY.. " Status: " ..vStatus.. " Timer: " ..vTimer)
	--if ( v ~= MyID) then
	--	TraceAI(v.. " target: " ..vTarget)
	--end
--
		Dt[v]={vAlliance,vType,vMotion,vLastX,vLastY,vStatus,vTimer}	
---
	end


	TraceAI("Enemy count is " ..EnemyCount.. " NeutralCount is " ..NeutralCount)
	--LastEnemyCount = EnemyCount
	--LastFrozenEnemies = FrozenEnemies
--=======================================================================================================

	--SkillObject(MyID,3,HVAN_SELFDESTRUCT,MyID)

	Buff2 = BuffTimers[MyID][OFFENSETIMER]
	Buff1 = BuffTimers[MyID][DEFENSETIMER]

	UsedSkill = 1
	--UsedAttack = 0
	if (JustSkilled > 0) then
		JustSkilled = JustSkilled -1
	elseif (LimitBreakTarget ~= 0) then -- sbr44 attack
		--error("sbr44")
		SkillObject(MyID,3,LimitBreak,LimitBreakTarget)
		LimitBreak = 0
	elseif (LimitBreak == HVAN_SELFDESTRUCT and LimitBreakCount >= VanExThreshold and MySP >= 1 and MyHP >= 8000) then --vanilbomb
		--error("vanilbomb")
		SkillObject(MyID,3,HVAN_SELFDESTRUCT,MyID)
		LimitBreak = 0
	elseif (UseDefender == 1 and Buff2 < CurrentTick and EnemyCount >= 1 and MySP >= 30) then
		SkillObject(MyID,3,ML_DEFENDER,MyID)
		BuffTimers[MyID][OFFENSETIMER] = CurrentTick + 180000
		JustSkilled = 1
		WriteBuffTimers()
		--turn off defender when using standby key?
	elseif (QuickenSkill ~= 0 and Buff2 < CurrentTick and MySP >= QuickenSp and (HomunClass == 0 or EnemyCount > 0 or (HomunClass == LIF and (SongBuffed ==1 or LifAlwaysSpeed == 1)))) then
		SkillObject(MyID,QuickenLevel,QuickenSkill,MyID)
		BuffTimers[MyID][OFFENSETIMER] = CurrentTick + QuickenDuration
		JustSkilled = 1
		WriteBuffTimers()
	elseif (DefenseSkill ~=0 and Buff1 < CurrentTick and MySP >= DefenseSp and (HomunClass == 0 or EnemyCount > 0) and (HomunClass ~= LIF or SongBuffed ==1 or LifAlwaysMental == 1)) then
		SkillObject(MyID,DefenseLevel,DefenseSkill,MyID)
		BuffTimers[MyID][DEFENSETIMER] = CurrentTick + DefenseDuration
		WriteBuffTimers()
	elseif (BerserkSkill == MER_AUTOBERSERK and AutoZerkOn == 0) then
		SkillObject(MyID,1,BerserkSkill,MyID)
		JustSkilled = 1
		AutoZerkOn = 1
	--elseif (BerserkSkill == HAMI_BLOODLUST and 
	elseif (BerserkSkill == MS_BERSERK and MySP >=200 and MyHPPercent <= 25) then
		if ((Buff2 - 10000) < CurrentTick) then
			SkillObject(MyID,QuickenLevel,QuickenSkill,MyID)
			JustSkilled = 1
			BuffTimers[MyID][OFFENSETIMER] = CurrentTick + QuickenDuration
			WriteBuffTimers()
		else
			SkillObject(MyID,1,BerserkSkill,MyID)
		end
	elseif (RescueSkill ~= 0 and OwnerHPPercent < RescueHpPercent and MySP >= RescueSp) then
		SkillObject(MyID,RescueLevel,RescueSkill,MyOwner)
		--if (RescueSkill == HAMI_CASTLE) then
			
		--end
	elseif (UseMagni == 1 and MySP >= 40 and Buff1 < CurrentTick and OwnerSPPercent < 80) then
		SkillObject(MyID,1,MER_MAGNIFICAT,MyID)
		BuffTimers[MyID][DEFENSETIMER] = CurrentTick + 35000
		WriteBuffTimers()
	elseif (RecoveryPriority ~= 15 and MySP >= RecoverySp) then
		if (RecoveryDistance <= 10) then
			SkillObject(MyID,1,RecoverySkill,RecoveryTarget)
			Dt[RecoveryTarget][TARGET_TIMER] = CurrentTick + RecoveryTimer
			--if ((RecoveryAlliance == OWNER or RecoveryAlliance == MERCENARY) and WriteActorInfo == 0) then
			--	WriteDt()
			--end
			RecoveryTarget = 0
		else
			Move(MyID,RecoveryX,RecoveryY)
			RecoveryTarget = 0
			UsedSkill = 0
		end
	elseif (DecloakPriority ~= -20 and MySP >= Decloak2Sp) then
		--error("love")
		if (Decloak2Method == 2) then
			TraceAI("Decloaktarget: " ..DecloakTarget.. "Decloak X,Y: "..DecloakX.. "," ..DecloakY)
			SkillGround(MyID,Decloak2Level,Decloak2Skill,DecloakX,DecloakY)
		else
			SkillObject(MyID,Decloak2Level,Decloak2Skill,MyID)
			if (Decloak2Skill == MER_SIGHT) then
				BuffTimers[MyID][OFFENSETIMER] = CurrentTick + 10000
			end
		end
	elseif (PushbackPriority ~= 0 and MySP >= PushbackSp) then
		if (PushbackX ~= 0) then
			SkillGround(MyID,PushbackLevel,PushbackSkill,PushbackX,PushbackY)
			Trap1Delay = CurrentTick +1000
		else
			SkillObject(MyID,PushbackLevel,PushbackSkill,PushbackTarget)
		end
	elseif (CastBreakPriority ~= 0 and CastBreakSkill ~= 0) then
		if(CastBreakSkill == MER_PROVOKE) then
			error("wtf castbreak")
			SkillObject(MyID,1,MER_PROVOKE,CastBreakTarget)
		elseif(CastBreakSkill == HVAN_CAPRICE) then
			SkillObject(MyID,VanCapriceLvl,HVAN_CAPRICE,CastBreakTarget)
		elseif(CastBreakSkill == MA_SHOWER) then
			SkillGround(MyID,10,MA_SHOWER,CastBreakX,CastBreakY)
		end
	elseif (ProvokeBuffTarget ~= 0) then
		SkillObject(MyID,ProvLevel,MER_PROVOKE,ProvokeBuffTarget)
		Dt[ProvokeBuffTarget][TARGET_TIMER] = CurrentTick + 30000
		JustSkilled = 1
	else
		UsedSkill = 0
	end

	if (CastBreakPriority ~= 0 and CastBreakSkill == 0) then
		Attack(MyID,CastBreakTarget)
		UsedAttack = 1
	end

	--if (UsedAttack == 1 or UsedSkill == 1) then
		--Move(MyID,MyDestX,MyDestY)
	--end

	if (Singer ~= 0 or KiteTarget == 2) then
		UsedAttack = 1
		UsedSkill = 1
	end
	--if (ChaseDistance > MyAttackRange and ChaseTarget > 0 ) then
	if (ChaseTarget > 0 and ChaseDistance > MyAttackRange ) then
		if ( AtkSkill ~= HVAN_CAPRICE) then
			UsedSkill = 1
		end
		UsedAttack = 1
	end

--====================================================


---diagnostics?
	--error("huhuh" ..DmgCheckList)
	--if (DmgCheckList == ScreenNeutrals) then
	--	error("huhuh")
	--	for v,c in pairs(DmgCheckList) do
	--		TraceAI("dmgchecklist target" ..v)
	--	end
	--end
	--qq=GetV(V_SKILLATTACKRANGE,MyID,HFLI_SBR44)
	--TraceAI("Skillrange is " ..qq)
       if ( HomunculusTarget ~= HomunculusTargetLast) then
               TraceAI("HomunculusTarget changed!")
               HomunculusTargetLast = HomunculusTarget
               if (ChaseTarget <= 0 and HomunculusTarget > 0) then
                       ChaseTarget = HomunculusTarget
               end
       end
	if ( MercenaryTarget ~= MercenaryTargetLast) then
		TraceAI("MercenaryTarget changed!")
		MercenaryTargetLast = MercenaryTarget
	end
	if ( OwnerTargetLast ~= OwnerTarget) then
		TraceAI("OwnerTarget changed!")
		OwnerTargetLast = OwnerTarget
	end
	--MercenaryTargetLast = MercenaryTarget
	--HomunculusTargetLast = HomunculusTarget
	--OwnerTargetLast = OwnerTarget
	OwnerLast = OwnerMotion
		
----------------------------------------------------------------------------------------------- 

	local msg	= GetMsg (myid)			-- command
	local rmsg	= GetResMsg (myid)		-- reserved command

	
	if msg[1] == NONE_CMD then
		if rmsg[1] ~= NONE_CMD then
			if List.size(ResCmdList) < 10 then
				List.pushright (ResCmdList,rmsg) -- ����E���� ����E
			end
		end
	else
		List.clear (ResCmdList)	-- ���ο�E������ �ԷµǸ�E����E���ɵ��� �����Ѵ�.  
		ProcessCommand (msg)	-- ���ɾ�Eó�� 
	end



 	if (MyState == IDLE_ST) then
		OnIDLE_ST ()
	elseif (MyState == CHASE_ST) then					
		OnCHASE_ST ()
	elseif (MyState == ATTACK_ST) then
		OnATTACK_ST ()
	elseif (MyState == FOLLOW_ST) then
		OnFOLLOW_ST ()
	elseif (MyState == MOVE_CMD_ST) then
		OnMOVE_CMD_ST ()
	elseif (MyState == STOP_CMD_ST) then
		OnSTOP_CMD_ST ()
	elseif (MyState == ATTACK_OBJECT_CMD_ST) then
		OnATTACK_OBJECT_CMD_ST ()
	elseif (MyState == ATTACK_AREA_CMD_ST) then
		OnATTACK_AREA_CMD_ST ()
	elseif (MyState == PATROL_CMD_ST) then
		OnPATROL_CMD_ST ()
	elseif (MyState == HOLD_CMD_ST) then
		OnHOLD_CMD_ST ()
	elseif (MyState == SKILL_OBJECT_CMD_ST) then
		OnSKILL_OBJECT_CMD_ST ()
	elseif (MyState == SKILL_AREA_CMD_ST) then
		OnSKILL_AREA_CMD_ST ()
	elseif (MyState == FOLLOW_CMD_ST) then
		OnFOLLOW_CMD_ST ()
	end

-------------------------------------------------------------------------------------------------end

	
	--PatrolMode = 0
	--if (MyLastX == MyX and MyLastY == MyY and UsedAttack ==0 and UsedSkill == 0) then
	if (MyLastX == MyX and MyLastY == MyY and (NormAtkTarget ~= MyTarget or MyTarget == 0)) then
		if (AntiStuckTimer < CurrentTick) then
			if (MyState == FOLLOW_ST) then
				MoveToOwnerDest()
				Move(MyID,MyDestX,MyDestY)
			elseif (MyState == MOVE_CMD_ST) then
				Move(MyID,MoveX,MoveY)
			end
			if (ChaseCheckList ~= nil) then
				ChaseCheckList[ChaseTarget] = nil
			end
			ChaseTarget = 0
			AntiStuckTimer = CurrentTick + 1500
		end
	else
		AntiStuckTimer = CurrentTick + 1500
	end
	if (HomunClass ~=0) then
		Dt[MyID][TARGET_TIMER] = CurrentTick +4000
		if (OwnerLastX == OwnerX and OwnerLastY == OwnerY) then
			if (AFKTimer < CurrentTick) then
				error("you are afk! "..AFKMaxTime.. " minutes have passed" , 0)
				--os.exit()
			end
		else
			AFKTimer = CurrentTick + AFKCountDown 
		end
	end
	--if (ActorDataClean > 0) then
	--	for v,i in pairs(Dt) do
	--		if (Dt[v] == nil) then
	--			error(" cleanup failed")
	--		end
	--		vAlliance = Dt[v][TARGET_ALLIANCE]
	--		vType = Dt[v][TARGET_TYPE]
	--		vLastMotion = Dt[v][TARGET_LMOTION]
	--		vLastX = Dt[v][TARGET_LASTX]
	--		vLastY = Dt[v][TARGET_LASTY]
	--		vStatus = Dt[v][TARGET_STATUS]
	--		vTimer = Dt[v][TARGET_TIMER]
	--		vDistance = 0
	--		if ((vAlliance == 0 and vStatus == 0 and vType == 0 and (vTimer +20000) < CurrentTick) or vDistance > 14) then		
	--			Dt[v] = nil
	--		end
	--	end
	--	ActorDataClean = 0
	--else
	--	ActorDataClean = ActorDataClean +1
	--end


	MyLastX = MyX
	MyLastY = MyY
	OwnerLastX = OwnerX
	OwnerLastY = OwnerY

	--if (HomunClass ~=0 and PVMMode ~= 1) then
	for v,i in pairs(Monsters) do
		if (i == 0) then
			--if (v == MercenaryTarget) then
			--	MercenaryTarget = MercenaryTarget * -1
			--end
			--if (v == HomunculusTarget) then
			--	HomunculusTarget = HomunculusTarget * -1
			--end
			--if (v == OwnerTarget) then
			--	error("ownernegativetarget")
			--	OwnerTarget = OwnerTarget * -1
			--end
			if (v == ChaseTarget) then
				ChaseTarget = 0
			end
			Dt[v] = nil
			Monsters[v] = nil
		end
	end
	if (WriteActorInfo == 1) then
		WriteDt()
	end
	TraceAI("AI cycle end" ..GetTick())
end


