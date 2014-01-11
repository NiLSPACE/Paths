
MaxSpeed = {}
CurrentPath = {}
Paths = {}
PLUGIN = Plugin

function Initialize(Plugin)
	PLUGIN = Plugin
	Plugin:SetName(g_PluginInfo.Name)
	Plugin:SetVersion(0)
	
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving)
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_JOINED, OnPlayerJoined)
	
	
	dofile(PLUGIN:GetLocalFolder() .. "/Info.lua")
	print(g_PluginInfo.Commands["/path"].Subcommands.add.Handler)
	RegisterPluginInfoCommands()
	
	cRoot:Get():ForEachPlayer(function(Player)
		local PlayerName = Player:GetName()
		Paths[PlayerName] = {}
		CurrentPath[PlayerName] = -1
	end)
	return true
end

function OnPlayerJoined(Player)
	CurrentPath[Player:GetName()] = -1
end

function OnPlayerMoving(Player)
	local PlayerName = Player:GetName()
	if CurrentPath[PlayerName] == -1 then
		return false
	end
	if not Player:IsFlying() then
		Player:SetFlying(true)
	end
	if Player:IsOnFire() then
		Player:StopBurning()
	end

	local DirectionVector = (Player:GetPosition() - Vector3d(Paths[PlayerName][CurrentPath[PlayerName]][1]))
	if DirectionVector:Length() < 1.5 then
		if tonumber(CurrentPath[PlayerName]) == tonumber(#Paths[PlayerName]) then
			Player:SendMessage("Last path")
			CurrentPath[PlayerName] = -1
			MaxSpeed[PlayerName] = -1
			return false
		end
		CurrentPath[PlayerName] = CurrentPath[PlayerName] + 1
	end
	if Player:GetSpeed():Length() / 2 > MaxSpeed[PlayerName] then
		Player:SetSpeed(Player:GetSpeed() / 2)
		return false
	end
	
	local Speed = DirectionVector:NormalizeCopy() * 2
	-- Invert the direction
	Speed.x = -Speed.x
	Speed.y = -Speed.y * 1.1
	Speed.z = -Speed.z
	
	local PlayerSpeed = Player:GetSpeed()
	if PlayerSpeed:Equals(PlayerSpeed) then  --Player speed is not 1.QNAN 
		Speed = (Speed + Player:GetSpeed())
	end
	Player:ForceSetSpeed(Speed)
	Player:SetSpeed(Speed)
end

function PrintVector(Vector)
	print(Vector.x, Vector.y, Vector.z, Vector:Length())
end