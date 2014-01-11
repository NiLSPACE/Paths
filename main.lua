
g_PluginInfo = nil
MaxSpeed = {}
CurrentPath = {}
Paths = {}
PLUGIN = Plugin

function Initialize(Plugin)
	g_PluginInfo = GetPluginInfo()
	
	PLUGIN = Plugin
	Plugin:SetName(g_PluginInfo.Name)
	Plugin:SetVersion(0)
	
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving)
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_JOINED, OnPlayerJoined)
	
	RegisterPluginInfoCommands()
	
	cRoot:Get():ForEachPlayer(function(Player)
		local PlayerName = Player:GetName()
		Paths[PlayerName] = {}
		CurrentPath[PlayerName] = -1
	end)
	return true
end

function OnDisable()
	cRoot:Get():ForEachPlayer(function(Player)
		if CurrentPath[Player:GetName()] ~= -1 then
			Player:SendMessage("Due to the plugin unloading the path was interupted.")
		end
	end)
end