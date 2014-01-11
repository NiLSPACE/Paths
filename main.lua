
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
	
	
	dofile(PLUGIN:GetLocalFolder() .. "/Info.lua") -- Disable to get errors.
	print(g_PluginInfo.Commands["/path"].Subcommands.add.Handler)
	RegisterPluginInfoCommands()
	
	cRoot:Get():ForEachPlayer(function(Player)
		local PlayerName = Player:GetName()
		Paths[PlayerName] = {}
		CurrentPath[PlayerName] = -1
	end)
	return true
end