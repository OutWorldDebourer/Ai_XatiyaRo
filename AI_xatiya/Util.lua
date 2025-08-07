

function GetDirection (MyX, MyY, TargetX, TargetY)
	HDirection = (TargetX - MyX)
	VDirection = (TargetY - MyY)
	if (math.abs(HDirection) > math.abs(VDirection)) then
		if (HDirection <= 0) then
			MyDirection = WEST
		else
			MyDirection = EAST
		end
	else
		if (VDirection >= 0) then
			MyDirection = NORTH
		else
			MyDirection = SOUTH
		end
	end
	return MyDirection			
end
	
function GetDirection2 (MyX, MyY, TargetX, TargetY)
-- add 1 to Tdistance? make it more "diagonal"
	TDistance = GetDistance(MyX, MyY, TargetX, TargetY)
	--error("tdistance " ..TDistance)
	HDirection = (TargetX - MyX)
	VDirection = (TargetY - MyY)
	AbsHDirection = math.abs(HDirection)
	AbsVDirection = math.abs(VDirection)
	
	if ((TDistance > AbsVDirection and TDistance > AbsHDirection) or AbsHDirection == AbsVDirection) then
		if (HDirection <= 0) then
			if (VDirection >= 0) then
				MyDirection = NORTHWEST
			else
				MyDirection = SOUTHWEST
			end
		else
			if (VDirection >= 0) then
				MyDirection = NORTHEAST
			else
				MyDirection = SOUTHEAST
			end	
		end
	else
		if (AbsHDirection > AbsVDirection) then
			if (HDirection <= 0) then
				MyDirection = WEST
			else
				MyDirection = EAST
			end
		else
			if (VDirection >= 0) then
				MyDirection = NORTH
			else
				MyDirection = SOUTH
			end
		end
	end
end

	

-- 5x5 area. super compact.

function TrapFormation1()
	--for TrapAttempt = 1, TrapAttemptLimit, 1 do		
		if (TrapCell < 13) then
			if (TrapCell == 1) then
				TrapX = MyX
				TrapY = MyY
			elseif (TrapCell == 2) then
				TrapX = MyX +1
				TrapY = MyY
			elseif (TrapCell == 3) then
				TrapX = MyX 
				TrapY = MyY -1
			elseif (TrapCell == 4) then
				TrapX = MyX -1
				TrapY = MyY 
			elseif (TrapCell == 5) then
				TrapX = MyX
				TrapY = MyY + 1
			elseif (TrapCell == 6) then
				TrapX = MyX +1
				TrapY = MyY +2
			elseif (TrapCell == 7) then
				TrapX = MyX +2
				TrapY = MyY +1
			elseif (TrapCell == 8) then
				TrapX = MyX +2
				TrapY = MyY -1
			elseif (TrapCell == 9) then
				TrapX = MyX +1
				TrapY = MyY -2
			elseif (TrapCell == 10) then
				TrapX = MyX -1
				TrapY = MyY -2
			elseif (TrapCell == 11) then
				TrapX = MyX -2
				TrapY = MyY -1
			elseif (TrapCell == 12) then
				TrapX = MyX -2
				TrapY = MyY +1
			end
		else
			if (TrapCell == 13) then
				TrapX = MyX -1
				TrapY = MyY +2
			elseif (TrapCell == 14) then
				TrapX = MyX +2
				TrapY = MyY +2
			elseif (TrapCell == 15) then
				TrapX = MyX +2
				TrapY = MyY -2
			elseif (TrapCell == 16) then
				TrapX = MyX -2
				TrapY = MyY -2
			elseif (TrapCell == 17) then
				TrapX = MyX -2
				TrapY = MyY +2
			elseif (TrapCell == 18) then
				TrapX = MyX
				TrapY = MyY +2
			elseif (TrapCell == 19) then
				TrapX = MyX +2
				TrapY = MyY
			elseif (TrapCell == 20) then
				TrapX = MyX
				TrapY = MyY -2
			elseif (TrapCell == 21) then
				TrapX = MyX -2
				TrapY = MyY
			elseif (TrapCell == 22) then
				TrapX = MyX -1
				TrapY = MyY +1
			elseif (TrapCell == 23) then
				TrapX = MyX +1
				TrapY = MyY +1
			elseif (TrapCell == 24) then
				TrapX = MyX +1
				TrapY = MyY -1
			elseif (TrapCell == 25) then
				TrapX = MyX -1
				TrapY = MyY -1
				TrapCell = 0
			end
		end
		TrapCell = TrapCell +1
		if ((Trap1Delay < CurrentTick or Trap1X ~= TrapX or Trap1Y ~= TrapY) and (Trap2Delay < CurrentTick or Trap2X ~= TrapX or Trap2Y ~= TrapY) and (Trap3Delay < CurrentTick or Trap3X ~= TrapX or Trap3Y ~= TrapY)) then
			SkillGround(MyID,TrapLevel2,TrapSkill,TrapX,TrapY)
			Trap3X,Trap3Y = Trap2X,Trap2Y
			Trap2X,Trap2Y = Trap1X,Trap1Y
			Trap1X,Trap1Y = TrapX,TrapY
			Trap3Delay = Trap2Delay
			Trap2Delay = Trap1Delay
			Trap1Delay = CurrentTick +1650
			--break
		end
	--end
end




--7x7 grid. alternating.
function TrapFormation2()
	--for TrapAttempt = 1, TrapAttemptLimit, 1 do		
		if (TrapCell < 13) then
			if (TrapCell == 1) then
				TrapX = MyX
				TrapY = MyY
			elseif (TrapCell == 2) then
				TrapX = MyX +1
				TrapY = MyY +1
			elseif (TrapCell == 3) then
				TrapX = MyX +1
				TrapY = MyY -1
			elseif (TrapCell == 4) then
				TrapX = MyX -1
				TrapY = MyY -1
			elseif (TrapCell == 5) then
				TrapX = MyX -1
				TrapY = MyY +1
			elseif (TrapCell == 6) then
				TrapX = MyX +3
				TrapY = MyY +3
			elseif (TrapCell == 7) then
				TrapX = MyX +3
				TrapY = MyY -3
			elseif (TrapCell == 8) then
				TrapX = MyX -3
				TrapY = MyY -3
			elseif (TrapCell == 9) then
				TrapX = MyX -3
				TrapY = MyY +3
			elseif (TrapCell == 10) then
				TrapX = MyX +2
				TrapY = MyY 
			elseif (TrapCell == 11) then
				TrapX = MyX
				TrapY = MyY -2
			elseif (TrapCell == 12) then
				TrapX = MyX -2
				TrapY = MyY 
			end
		else
			if (TrapCell == 13) then
				TrapX = MyX
				TrapY = MyY +2
			elseif (TrapCell == 14) then
				TrapX = MyX +2
				TrapY = MyY +2
			elseif (TrapCell == 15) then
				TrapX = MyX +2
				TrapY = MyY -2
			elseif (TrapCell == 16) then
				TrapX = MyX -2
				TrapY = MyY -2
			elseif (TrapCell == 17) then
				TrapX = MyX -2
				TrapY = MyY +2
			elseif (TrapCell == 18) then
				TrapX = MyX +3
				TrapY = MyY +1
			elseif (TrapCell == 19) then
				TrapX = MyX +1
				TrapY = MyY -3
			elseif (TrapCell == 20) then
				TrapX = MyX -3
				TrapY = MyY -1
			elseif (TrapCell == 21) then
				TrapX = MyX -1
				TrapY = MyY +3
			elseif (TrapCell == 22) then
				TrapX = MyX +3
				TrapY = MyY -1
			elseif (TrapCell == 23) then
				TrapX = MyX -1
				TrapY = MyY -3
			elseif (TrapCell == 24) then
				TrapX = MyX -3
				TrapY = MyY +1
			elseif (TrapCell == 25) then
				TrapX = MyX +1
				TrapY = MyY +3
				TrapCell = 0
			end
		end
		TrapCell = TrapCell +1
		if ((Trap1Delay < CurrentTick or Trap1X ~= TrapX or Trap1Y ~= TrapY) and (Trap2Delay < CurrentTick or Trap2X ~= TrapX or Trap2Y ~= TrapY) and (Trap3Delay < CurrentTick or Trap3X ~= TrapX or Trap3Y ~= TrapY)) then
			SkillGround(MyID,TrapLevel2,TrapSkill,TrapX,TrapY)
			Trap3X,Trap3Y = Trap2X,Trap2Y
			Trap2X,Trap2Y = Trap1X,Trap1Y
			Trap1X,Trap1Y = TrapX,TrapY
			Trap3Delay = Trap2Delay
			Trap2Delay = Trap1Delay
			Trap1Delay = CurrentTick +1650
			--break
		end
	--end
end

--9x9 grid. the most spread out
function TrapFormation3()
	--for TrapAttempt = 1, TrapAttemptLimit, 1 do		
		if (TrapCell < 13) then
			if (TrapCell == 1) then
				TrapX = MyX
				TrapY = MyY
			elseif (TrapCell == 2) then
				TrapX = MyX +4
				TrapY = MyY +4
			elseif (TrapCell == 3) then
				TrapX = MyX +4
				TrapY = MyY -4
			elseif (TrapCell == 4) then
				TrapX = MyX -4
				TrapY = MyY -4
			elseif (TrapCell == 5) then
				TrapX = MyX -4
				TrapY = MyY +4
			elseif (TrapCell == 6) then
				TrapX = MyX +2
				TrapY = MyY
			elseif (TrapCell == 7) then
				TrapX = MyX
				TrapY = MyY -2
			elseif (TrapCell == 8) then
				TrapX = MyX -2
				TrapY = MyY
			elseif (TrapCell == 9) then
				TrapX = MyX
				TrapY = MyY +2
			elseif (TrapCell == 10) then
				TrapX = MyX +4
				TrapY = MyY -2
			elseif (TrapCell == 11) then
				TrapX = MyX -2
				TrapY = MyY -4
			elseif (TrapCell == 12) then
				TrapX = MyX -4
				TrapY = MyY +2
			end
		else
			if (TrapCell == 13) then
				TrapX = MyX +2
				TrapY = MyY +4
			elseif (TrapCell == 14) then
				TrapX = MyX +2
				TrapY = MyY -2
			elseif (TrapCell == 15) then
				TrapX = MyX -2
				TrapY = MyY -2
			elseif (TrapCell == 16) then
				TrapX = MyX -2
				TrapY = MyY +2
			elseif (TrapCell == 17) then
				TrapX = MyX +2
				TrapY = MyY +2
			elseif (TrapCell == 18) then
				TrapX = MyX
				TrapY = MyY -4
			elseif (TrapCell == 19) then
				TrapX = MyX -4
				TrapY = MyY
			elseif (TrapCell == 20) then
				TrapX = MyX
				TrapY = MyY +4
			elseif (TrapCell == 21) then
				TrapX = MyX +4
				TrapY = MyY
			elseif (TrapCell == 22) then
				TrapX = MyX +2
				TrapY = MyY -4
			elseif (TrapCell == 23) then
				TrapX = MyX -4
				TrapY = MyY -2
			elseif (TrapCell == 24) then
				TrapX = MyX -2
				TrapY = MyY +4
			elseif (TrapCell == 25) then
				TrapX = MyX +4
				TrapY = MyY +2
				TrapCell = 0
			end
		end
		TrapCell = TrapCell +1
		if ((Trap1Delay < CurrentTick or Trap1X ~= TrapX or Trap1Y ~= TrapY) and (Trap2Delay < CurrentTick or Trap2X ~= TrapX or Trap2Y ~= TrapY) and (Trap3Delay < CurrentTick or Trap3X ~= TrapX or Trap3Y ~= TrapY)) then
			SkillGround(MyID,TrapLevel2,TrapSkill,TrapX,TrapY)
			Trap3X,Trap3Y = Trap2X,Trap2Y
			Trap2X,Trap2Y = Trap1X,Trap1Y
			Trap1X,Trap1Y = TrapX,TrapY
			Trap3Delay = Trap2Delay
			Trap2Delay = Trap1Delay
			Trap1Delay = CurrentTick +1650
			--break
		end
	--end
end


--special. for graffiti.
function TrapFormation4()
	--for TrapAttempt = 1, TrapAttemptLimit, 1 do		
		if (TrapCell < 13) then
			if (TrapCell == 1) then
				TrapX = MyX
				TrapY = MyY
			elseif (TrapCell == 2) then
				TrapX = MyX +4
				TrapY = MyY +4
			elseif (TrapCell == 3) then
				TrapX = MyX -4
				TrapY = MyY -4
			elseif (TrapCell == 4) then
				TrapX = MyX
				TrapY = MyY +4
			elseif (TrapCell == 5) then
				TrapX = MyX -1
				TrapY = MyY +4
			elseif (TrapCell == 6) then
				TrapX = MyX -2
				TrapY = MyY +4
			elseif (TrapCell == 7) then
				TrapX = MyX -3
				TrapY = MyY +3
			elseif (TrapCell == 8) then
				TrapX = MyX -3
				TrapY = MyY +2
			elseif (TrapCell == 9) then
				TrapX = MyX -2
				TrapY = MyY +2
			elseif (TrapCell == 10) then
				TrapX = MyX -1
				TrapY = MyY +2
			elseif (TrapCell == 11) then
				TrapX = MyX -1
				TrapY = MyY +1
			elseif (TrapCell == 12) then
				TrapX = MyX -2
				TrapY = MyY 
			end
		else
			if (TrapCell == 13) then
				TrapX = MyX -3
				TrapY = MyY
			elseif (TrapCell == 14) then
				TrapX = MyX -4
				TrapY = MyY
			elseif (TrapCell == 15) then
				TrapX = MyX +4
				TrapY = MyY
			elseif (TrapCell == 16) then
				TrapX = MyX +3
				TrapY = MyY
			elseif (TrapCell == 17) then
				TrapX = MyX +2
				TrapY = MyY
			elseif (TrapCell == 18) then
				TrapX = MyX +1
				TrapY = MyY -1
			elseif (TrapCell == 19) then
				TrapX = MyX +1
				TrapY = MyY -2
			elseif (TrapCell == 20) then
				TrapX = MyX +2
				TrapY = MyY -2
			elseif (TrapCell == 21) then
				TrapX = MyX +3
				TrapY = MyY -2
			elseif (TrapCell == 22) then
				TrapX = MyX +3
				TrapY = MyY -3
			elseif (TrapCell == 23) then
				TrapX = MyX +2
				TrapY = MyY -4
			elseif (TrapCell == 24) then
				TrapX = MyX +1
				TrapY = MyY -4
			elseif (TrapCell == 25) then
				TrapX = MyX
				TrapY = MyY -4
				TrapCell = 0
			end
		end
		TrapCell = TrapCell +1
		if ((Trap1Delay < CurrentTick or Trap1X ~= TrapX or Trap1Y ~= TrapY) and (Trap2Delay < CurrentTick or Trap2X ~= TrapX or Trap2Y ~= TrapY) and (Trap3Delay < CurrentTick or Trap3X ~= TrapX or Trap3Y ~= TrapY)) then
			SkillGround(MyID,1,TrapSkill,TrapX,TrapY)
			Trap3X,Trap3Y = Trap2X,Trap2Y
			Trap2X,Trap2Y = Trap1X,Trap1Y
			Trap1X,Trap1Y = TrapX,TrapY
			Trap3Delay = Trap2Delay
			Trap2Delay = Trap1Delay
			Trap1Delay = CurrentTick +1650
			--break
		end
	--end
end


function TrapFormation5()
	if (MyDirection <= SOUTH ) then
		
		--for TrapAttempt = 1, TrapAttemptLimit, 1 do
---------
			if (TrapCell < 13) then
				if (TrapCell == 1) then
					TrapX = 0
					TrapY = 0
				elseif (TrapCell == 2) then
					TrapX = 0
					TrapY = 1
				elseif (TrapCell == 3) then
					TrapX = 1
					TrapY = 0
				elseif (TrapCell == 4) then
					TrapX = 0
					TrapY = -1
				elseif (TrapCell == 5) then
					TrapX = -1
					TrapY = 0
				elseif (TrapCell == 6) then
					TrapX = -4
					TrapY = 4
				elseif (TrapCell == 7) then
					TrapX = -4
					TrapY = -4
				elseif (TrapCell == 8) then
					TrapX = -3
					TrapY = 2
				elseif (TrapCell == 9) then
					TrapX = -3
					TrapY = -2
				elseif (TrapCell == 10) then
					TrapX = -4
					TrapY = 0
				elseif (TrapCell == 11) then
					TrapX = -2
					TrapY = 4
				elseif (TrapCell == 12) then
					TrapX = -2
					TrapY = -4
				end
			else
				if (TrapCell == 13) then
					TrapX = -3
					TrapY = 0
				elseif (TrapCell == 14) then
					TrapX = -3
					TrapY = 1
				elseif (TrapCell == 15) then
					TrapX = -3
					TrapY = -1
				elseif (TrapCell == 16) then
					TrapX = -4
					TrapY = 3
				elseif (TrapCell == 17) then
					TrapX = -4
					TrapY = -3
				elseif (TrapCell == 18) then
					TrapX = -3
					TrapY = 4
				elseif (TrapCell == 19) then
					TrapX = -3
					TrapY = -4
				elseif (TrapCell == 20) then
					TrapX = -4
					TrapY = 1
				elseif (TrapCell == 21) then
					TrapX = -4
					TrapY = -1
				elseif (TrapCell == 22) then
					TrapX = -3
					TrapY = 3
				elseif (TrapCell == 23) then
					TrapX = -3
					TrapY = -3
				elseif (TrapCell == 24) then
					TrapX = -4
					TrapY = 2
				elseif (TrapCell == 25) then
					TrapX = -4
					TrapY = -2
					TrapCell = 0
				end
			end
-------
-- Direction based coordinate flip
			if (MyDirection == EAST) then
				TrapX = (TrapX * -1)
			elseif (MyDirection ~= WEST) then
				local X = TrapX
				TrapX = TrapY
				TrapY = X
				if (MyDirection == NORTH) then		
					TrapY = (TrapY * -1)
				end
			end
			--SkillGround(MyID, TrapLevel, TrapSkill, MyX, MyY)
			TrapX = MyX+TrapX
			TrapY = MyY+TrapY
			TrapCell = TrapCell +1
			if ((Trap1Delay < CurrentTick or Trap1X ~= TrapX or Trap1Y ~= TrapY) and (Trap2Delay < CurrentTick or Trap2X ~= TrapX or Trap2Y ~= TrapY) and (Trap3Delay < CurrentTick or Trap3X ~= TrapX or Trap3Y ~= TrapY)) then
				SkillGround(MyID,TrapLevel2,TrapSkill,TrapX,TrapY)	
				Trap3X,Trap3Y = Trap2X,Trap2Y
				Trap2X,Trap2Y = Trap1X,Trap1Y
				Trap1X,Trap1Y = TrapX,TrapY
				Trap3Delay = Trap2Delay
				Trap2Delay = Trap1Delay
				Trap1Delay = CurrentTick +1650
				--break
			end
		--end
	else
		--for TrapAttempt = 1, TrapAttemptLimit, 1 do
			if (TrapCell < 13) then
				if (TrapCell == 1) then
					TrapX = 0
					TrapY = 0
				elseif (TrapCell == 2) then
					TrapX = -1
					TrapY = 0
				elseif (TrapCell == 3) then
					TrapX = 0
					TrapY = 1
				elseif (TrapCell == 4) then
					TrapX = 1
					TrapY = 0
				elseif (TrapCell == 5) then
					TrapX = 0
					TrapY = -1
				elseif (TrapCell == 6) then
					TrapX = -4
					TrapY = -1
				elseif (TrapCell == 7) then
					TrapX = -4
					TrapY = 4
				elseif (TrapCell == 8) then
					TrapX = 1
					TrapY = 4
				elseif (TrapCell == 9) then
					TrapX = -3
					TrapY = 1
				elseif (TrapCell == 10) then
					TrapX = -1
					TrapY = 3
				elseif (TrapCell == 11) then
					TrapX = -3
					TrapY = 3
				elseif (TrapCell == 12) then
					TrapX = -4
					TrapY = 2
				end
			else
				if (TrapCell == 13) then
					TrapX = -2
					TrapY = 4
				elseif (TrapCell == 14) then
					TrapX = -4
					TrapY = 0
				elseif (TrapCell == 15) then
					TrapX = 0
					TrapY = 4
				elseif (TrapCell == 16) then
					TrapX = -3
					TrapY = -1
				elseif (TrapCell == 17) then
					TrapX = 1
					TrapY = 3
				elseif (TrapCell == 18) then
					TrapX = -4
					TrapY = 3
				elseif (TrapCell == 19) then
					TrapX = -3
					TrapY = 4
				elseif (TrapCell == 20) then
					TrapX = -4
					TrapY = 1
				elseif (TrapCell == 21) then
					TrapX = -1
					TrapY = 4
				elseif (TrapCell == 22) then
					TrapX = -3
					TrapY = 0
				elseif (TrapCell == 23) then
					TrapX = 0
					TrapY = 3
				elseif (TrapCell == 24) then
					TrapX = -3
					TrapY = 2
				elseif (TrapCell == 25) then
					TrapX = -2
					TrapY = 3
					TrapCell = 0
				end
			end
			if (MyDirection == NORTHEAST) then
				TrapX = (TrapX * -1)
			elseif (MyDirection ~= NORTHWEST) then
				TrapY = (TrapY * -1)
				if (MyDirection == SOUTHEAST) then		
					TrapX = (TrapX * -1)
				end
			end
			TrapX = MyX+TrapX
			TrapY = MyY+TrapY
			TrapCell = TrapCell +1
			if ((Trap1Delay < CurrentTick or Trap1X ~= TrapX or Trap1Y ~= TrapY) and (Trap2Delay < CurrentTick or Trap2X ~= TrapX or Trap2Y ~= TrapY) and (Trap3Delay < CurrentTick or Trap3X ~= TrapX or Trap3Y ~= TrapY)) then
				SkillGround(MyID,TrapLevel2,TrapSkill,TrapX,TrapY)
				Trap3X,Trap3Y = Trap2X,Trap2Y
				Trap2X,Trap2Y = Trap1X,Trap1Y
				Trap1X,Trap1Y = TrapX,TrapY
				Trap3Delay = Trap2Delay
				Trap2Delay = Trap1Delay
				Trap1Delay = CurrentTick +1650
				--break
			end
		--end
	end	
end

function WriteBuffTimers()
	TimeoutFile = io.open("AI_xatiya/Timeout.txt", "w")
	TimeoutFile:write ("MiscTimer=" ..MiscTimer.. "\n")
	for v,i in pairs(BuffTimers) do
		if (v > 0 ) then
			DefenseTimer = BuffTimers[v][DEFENSETIMER]
			OffenseTimer = BuffTimers[v][OFFENSETIMER]
			TimeoutFile:write ("BuffTimers["..v.."]={" ..DefenseTimer.. "," ..OffenseTimer.. "} -- \n")
		end
	end
	TimeoutFile:close()
end


function WriteDt()
	ActorFile = io.open("AI_xatiya/ActorList.txt", "w")
	for v,i in pairs(Dt) do
		vAlliance = Dt[v][TARGET_ALLIANCE]
		vType = Dt[v][TARGET_TYPE]
		vLastMotion = Dt[v][TARGET_LMOTION]
		vLastX = Dt[v][TARGET_LASTX]
		vLastY = Dt[v][TARGET_LASTY]
		vStatus = Dt[v][TARGET_STATUS]
		vTimer = Dt[v][TARGET_TIMER]
		--TraceAI("writing " ..v.. " to ActorData") 
		if (vAlliance ~= 0 or vStatus ~= 0 or vType ~= 0) then
			ActorFile:write ("Dt["..v.."]={" ..vAlliance.. "," ..vType.. "," ..vLastMotion.. "," ..vLastX.. "," ..vLastY.. "," ..vStatus.. "," ..vTimer.."}\n")
		end
	end
	ActorFile:close()
end

function MoveToOwnerIdle()
	if (MyX > OwnerX + IdleDistance) then
		MyDestX=OwnerX + IdleDistance
	elseif (MyX < OwnerX - IdleDistance) then
		MyDestX=OwnerX - IdleDistance
	else
		MyDestX=MyX
	end
	if (MyY > OwnerY + IdleDistance) then
		MyDestY=OwnerY + IdleDistance
	elseif (MyY < OwnerY - IdleDistance) then
		MyDestY=OwnerY - IdleDistance
	else
		MyDestY=MyY
	end
	--Move(MyID,MyDestX,MyDestY)
	TraceAI("Moving to " ..MyDestX.. "," ..MyDestY)
	return 
end

function MoveToOwnerDest()
	if (MyX > OwnerX + FollowDistance) then
		MyDestX=OwnerX + FollowDistance
	elseif (MyX < OwnerX - FollowDistance) then
		MyDestX=OwnerX - FollowDistance
	else
		MyDestX=MyX
	end
	if (MyY > OwnerY + FollowDistance) then
		MyDestY=OwnerY + FollowDistance
	elseif (MyY < OwnerY - FollowDistance) then
		MyDestY=OwnerY - FollowDistance
	else
		MyDestY=MyY
	end
	--Move(MyID,MyDestX,MyDestY)
	TraceAI("Moving to " ..MyDestX.. "," ..MyDestY)
	return 
end

function AOEBestGround(range,radius)
	BestSplashCount = 0
	BestX, BestY = 0,0
	for v,c in pairs(ScreenEnemies) do
		vX, vY = GetV (V_POSITION,v)
		CoordinateList = {}
		CoordinateList[1] = {vX,vY}
		CoordinateList[2] = {(vX - radius),(vY - radius)}
		CoordinateList[3] = {(vX - radius),(vY + radius)}
		CoordinateList[4] = {(vX + radius),(vY + radius)}
		CoordinateList[5] = {(vX + radius),(vY - radius)}
		for w,q in ipairs(CoordinateList) do
			qX = CoordinateList[w][1]
			qY = CoordinateList[w][2]
			if (GetDistance(MyX, MyY, qX, qY) <= range) then
				--error("kablah")
				Icebreaker = 0
				for l,p in ipairs(FrozenEnemies) do
					--error("kablah") --no frozen enemies even when freeze trapping?
					pX, pY = GetV (V_POSITION,p)
					if(GetDistance(qX, qY, pX, pY) <= radius) then
						Icebreaker = 1
						--error("kablah")
						break
					end
				end
				if (Icebreaker == 0) then
					SplashCount = 0
					for k,n in pairs(ScreenEnemies) do
						--error("kablah")
						kX, kY = GetV (V_POSITION,k)
						if (GetDistance(qX, qY, kX, kY) <= radius) then
							SplashCount = SplashCount +1
						end
					end
					if (SplashCount > BestSplashCount) then
						--error("kablah")
						BestSplashCount = SplashCount
						BestX,BestY = qX,qY
					end
				end
			end
		end
	end
	return BestSplashCount, BestX, BestY
end

--unused
function AOEBestGround2(range,radius)
	BestSplashCount = 0
	BestX, BestY = 0,0
	for v,c in pairs(ScreenEnemies) do
		vX, vY = GetV (V_POSITION,v)
		CoordinateList = {}
		CoordinateList[1] = {vX,vY}
		CoordinateList[2] = {(vX - radius),(vY - radius)}
		CoordinateList[3] = {(vX - radius),(vY + radius)}
		CoordinateList[4] = {(vX + radius),(vY + radius)}
		CoordinateList[5] = {(vX + radius),(vY - radius)}
		for w,q in ipairs(CoordinateList) do
			qX = CoordinateList[w][1]
			qY = CoordinateList[w][2]
			if (GetDistance(MyX, MyY, qX, qY) <= range) then
				SplashCount = 0
				for k,n in pairs(ScreenEnemies) do
					nX, nY = GetV (V_POSITION,n)
					if (GetDistance(qX, qY, nX, nY) <= radius) then
						SplashCount = SplashCount +1
					end
				end
				if (SplashCount > BestSplashCount) then
					BestSplashCount = SplashCount
					BestX,BestY = qX,qY
				end
			end
		end
	end
	return BestSplashCount, BestX, BestY
end

function AOEBestTarget(range,radius)
	BestSplashCount = 0
	BestX, BestY = 0,0
	for v,c in pairs(ScreenEnemies) do
		vX, vY = GetV (V_POSITION,v)
		TraceAI("enemy " ..v.. " location " ..vX.. "," ..vY)
		if (GetDistance(MyX, MyY, vX, vY) <= range) then
			Icebreaker = 0
			for l,p in ipairs(FrozenEnemies) do
				pX, pY = GetV (V_POSITION,p)
				if(GetDistance(vX, vY, pX, pY) <= radius) then
					Icebreaker = 1
					break
				end
			end
			if (Icebreaker == 0) then
				SplashCount = 1
				for k,n in ipairs(ScreenEnemies) do
					error("blah")
					nX, nY = GetV (V_POSITION,n)
					if (GetDistance(vX, vY, nX, nY) <= radius) then
						SplashCount = SplashCount +1
					end
				end
				if (SplashCount > BestSplashCount) then
					BestSplashCount = SplashCount
					BestTarget = v
				end
			end
		end
	end
	return BestSplashCount, BestTarget
end

function AOESelfCheck(radius)
	SplashCount = 0
	for v,c in pairs(ScreenEnemies) do
		vX, vY = GetV (V_POSITION,v)
		if (GetDistance(MyX, MyY, vX, vY) <= radius) then
			SplashCount = SplashCount +1
		end
	end
	return SplashCount
end




function GetDistanceSquare(MeX, MeY, TargX, TargY)
	xSquareDistance = math.abs(MeX - TargX)
	ySquareDistance = math.abs(MeY - TargY)
	if (xSquareDistance > ySquareDistance) then
		return xSquareDistance
	else
		return ySquareDistance
	end
end

function modulo(a,b)
	return a-math.floor(a/b)*b
end

--function WriteTimeouts()
--	TimeoutFile = io.open("AI_xatiya/Timeout.txt", "w")
--	TimeoutFile:write ("MiscTimer=" ..MiscTimer.. "\nMercBuff1=" ..MercBuff1.. "\nMercBuff2=" ..MercBuff2.. "\nHomunBuff1=" ..HomunBuff1.. "\nHomunBuff2=" ..HomunBuff2.. "\nHomunAware=" ..HomunAware.. "\nHomunCycleLast=" ..HomunCycleLast)
--	TimeoutFile:close()
--end

function RecoverySetTarget(v)
	if (RecoveryPriority > vAlliance) then
		RecoveryTarget = v
		if (vDistance >= 10) then
			RecoveryPriority = vAlliance +8
		else
			RecoveryPriority = vAlliance
		end
		RecoveryDistance = vDistance
		RecoveryX = vX
		RecoveryY = vY
	end
end

function TrapAffected()
	for v,c in pairs(ScreenEnemies) do
		vX, vY = GetV (V_POSITION,v)
		if (TrapSkill == MA_SANDMAN) then
			if (GetDistance(TrapX, TrapY, vX, vY) <= 2) then
				Dt[v][TARGET_STATUS] = FROZEN
				Dt[v][TARGET_TIMER] = CurrentTick + 300
			end
		elseif (TrapSkill == MA_FREEZINGTRAP) then
			if (GetDistance(TrapX, TrapY, vX, vY) <= 1) then
				Dt[v][TARGET_STATUS] = FROZEN
				Dt[v][TARGET_TIMER] = CurrentTick + 300
				TraceAI(v.. " is frozen")
			end
		end
	end
end


function Closer(MeX,MeY,vx,vy)
	--closerx,closery=0,0
	if (vx > MeX) then
		closerx=vx-1
	else
		closerx=vx+1
	end
	if (vy > MeY) then
		closery=vy-1
	else
		closery=vy+1
	end
	return closerx,closery
end

function CloserM(MeX,MeY,vx,vy,minrange)
	closerx,closery = MeX,MeY
	xdist = math.abs(MeX - vx)
	if (xdist > minrange) then
		if (vx > MeX) then
			closerx=vx-minrange
		else
			closerx=vx+minrange
		end
	end
	ydist = math.abs(MeY - vy)
	if (ydist > minrange) then
		if (vy > MeY) then
			closery=vy-minrange
		else
			closery=vy+minrange
		end
	end
	return closerx,closery
end

function Closest(MeX,MeY,vx,vy)
	--closerx,closery=0,0
	if (vx > MeX) then
		closerx=vx-2
	else
		closerx=vx+2
	end
	if (vy > MeY) then
		closery=vy-2
	else
		closery=vy+2
	end
	return closerx,closery
end

function GetSquareDistance(MeX, MeY, TargX, TargY)
	xSquareDistance = math.abs(MeX - TargX)
	ySquareDistance = math.abs(MeY - TargY)
	if (xSquareDistance > ySquareDistance) then
		return xSquareDistance
	else
		return ySquareDistance
	end
end


--------------------------------------------
-- List utility. 
--------------------------------------------
List = {}

function List.new ()
	return { first = 0, last = -1}
end

function List.pushleft (list, value)
	local first = list.first-1
	list.first  = first
	list[first] = value;
end

function List.pushright (list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
end

function List.popleft (list)
	local first = list.first
	if first > list.last then 
		return nil
	end
	local value = list[first]
	list[first] = nil         -- to allow garbage collection
	list.first = first+1
	return value
end

function List.popright (list)
	local last = list.last
	if list.first > last then
		return nil
	end
	local value = list[last]
	list[last] = nil
	list.last = last-1
	return value 
end

function List.clear (list)
	for i,v in ipairs(list) do
		list[i] = nil
	end
--[[
	if List.size(list) == 0 then
		return
	end
	local first = list.first
	local last  = list.last
	for i=first, last do
		list[i] = nil
	end
--]]
	list.first = 0
	list.last = -1
end

function List.size (list)
	local size = list.last - list.first + 1
	return size
end

-------------------------------------------------

function	GetDistance (x1,y1,x2,y2)
	return math.floor(math.sqrt((x1-x2)^2+(y1-y2)^2))
end

function GetAttackRange()
	MyAttackRange= GetV(V_ATTACKRANGE, MyID)
	return MyAttackRange
end

function Eclipse()
end