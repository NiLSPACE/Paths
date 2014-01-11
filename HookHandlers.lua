--[[Create a table for the player]]--
function OnPlayerJoined(Player)
	local PlayerName = Player:GetName()
	CurrentPath[PlayerName] = -1
	Paths[PlayerName] = {}
end




--[[Manage the movement]]--
function OnPlayerMoving(Player)
	local PlayerName = Player:GetName()
	-- Player isn't in path mode
	if CurrentPath[PlayerName] == -1 then
		return false
	end
	--Player has to be flying to get the best results.
	if not Player:IsFlying() then
		Player:SetFlying(true)
	end
	--It isn't nice to see half of the screen full of fire while sightseeing
	if Player:IsOnFire() then
		Player:StopBurning()
	end

	local DirectionVector = (Player:GetPosition() - Vector3d(Paths[PlayerName][CurrentPath[PlayerName]][1]))
	if DirectionVector:Length() < 1.5 then
		if tonumber(CurrentPath[PlayerName]) == tonumber(#Paths[PlayerName]) then
			Player:SendMessage(cChatColor.LightGreen .. "You have reached the latest waypoint.")
			CurrentPath[PlayerName] = -1
			MaxSpeed[PlayerName] = -1
			return false
		end
		CurrentPath[PlayerName] = CurrentPath[PlayerName] + 1
	end
	
	-- Without a limit the player would just speed up and speed up.. wich isn't good.
	if Player:GetSpeed():Length() / 2 > MaxSpeed[PlayerName] then
		Player:SetSpeed(Player:GetSpeed() / 2)
		return false
	end
	local Speed = DirectionVector:NormalizeCopy() * 2
	-- Invert the direction
	Speed.x = -Speed.x
	Speed.y = -Speed.y
	Speed.z = -Speed.z
	
	local PlayerSpeed = Player:GetSpeed()
	if PlayerSpeed:Equals(PlayerSpeed) then  --Player speed is not 1.QNAN 
		Speed = (Speed + Player:GetSpeed())
	end
	Player:ForceSetSpeed(Speed)
	Player:SetSpeed(Speed)
end
