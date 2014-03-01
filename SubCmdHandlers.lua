--[[This command adds a waypoint to someones path]]--
function HandleSubCmdAdd(Split, Player)
	local PlayerName = Player:GetName()
	if Paths[PlayerName] == nil then -- The player doesn't have a pad. WEIRD!
		Paths[PlayerName] = {}
	end
	-- Insert the new position in the paths.
	table.insert(Paths[PlayerName], {Vector3f(Player:GetPosition()), Vector3f(Player:GetRot())})
	Player:SendMessage("New path added ID:" .. #Paths[PlayerName] .. " X:" .. string.sub(Player:GetPosX(), 1, string.len(math.floor(Player:GetPosX())) + 2) .. " Y:" .. string.sub(Player:GetPosY(), 1, string.len(math.floor(Player:GetPosY())) + 2) .. " Z:" .. string.sub(Player:GetPosZ(), 1, string.len(math.floor(Player:GetPosZ())) + 2))
	return true
end




--[[This command clears all the waypoints a player has created]]--
function HandleSubCmdClear(Split, Player)
	local PlayerName = Player:GetName()
	CurrentPath[PlayerName] = -1
	Paths[PlayerName] = {}
	Player:SendMessage(cChatColor.LightGreen .. "Paths are cleared")
	return true
end




--[[This sets everything in motion. When you use this command with a speed you go through all your waypoints]]--
function HandleSubCmdStart(Split, Player)
	local PlayerName = Player:GetName()
	-- The given speed was not a number. Lets bail out.
	if Split[3] == nil or tonumber(Split[3]) == nil then
		Player:SendMessage("Usage: /path Start <Speed>")
		return true
	end
	
	-- The player doesn't have any waypoints. Lets bail out.
	if #Paths[PlayerName] < 1 then
		Player:SendMessage("You don't have any paths set up")
		return true
	end
	
	-- Teleport to the first waypoint and lets get this player moving!
	Player:TeleportToCoords(Paths[PlayerName][1][1].x, Paths[PlayerName][1][1].y, Paths[PlayerName][1][1].z)
	CurrentPath[PlayerName] = 1
	MaxSpeed[PlayerName] = tonumber(Split[3])
	
	Player:SendMessage(cChatColor.LightGreen .. "Path Started with a max speed of " .. Split[3])
	return true
end




--[[This command stops the plugin from moving you from waypoint to waypoint.]]--
function HandleSubCmdStop(Split, Player)
	CurrentPath[Player:GetName()] = -1
	Player:SendMessage(cChatColor.Red .. "Path stopped")
	return true
end




--[[This allows you to replace a certain waypoint with a new one]]--
function HandleSubCmdReplace(Split, Player)
	-- Once again the given waypoint isn't a valid ID
	if Split[3] == nil or tonumber(Split[3]) == nil then
		Player:SendMessage(cChatColor.Rose .. "Usage: /path replace <ID>")
		return true
	end
	
	local ID = tonumber(Split[3])
	local PlayerName = Player:GetName()
	-- The path doesn't exist so we can't replace anything.
	if Paths[PlayerName][ID] == nil then
		Player:SendMessage(cChatColor.Rose .. "Path ID does not exist.")
		return true
	end
	
	Paths[PlayerName][ID] = {Vector3f(Player:GetPosition()), Vector3f(Player:GetRot())}
	Player:SendMessage("Path " .. ID .. " is replaced. New coordinates are: " .. "X:" .. string.sub(Player:GetPosX(), 1, string.len(math.floor(Player:GetPosX())) + 2) .. " Y:" .. string.sub(Player:GetPosY(), 1, string.len(math.floor(Player:GetPosY())) + 2) .. " Z:" .. string.sub(Player:GetPosZ(), 1, string.len(math.floor(Player:GetPosZ())) + 2))
	return true
end




--[[Allows you to remove a waypoint from your path]]--
function HandleSubCmdRemove(Split, Player)
	-- The given ID isn't an ID
	if Split[3] == nil or tonumber(Split[3]) == nil then
		Player:SendMessage(cChatColor.Rose .. "Usage: /path remove <ID>")
		return true
	end
	
	local ID = tonumber(Split[3])
	local PlayerName = Player:GetName()
	-- The path doesn't exist so we can't remove anything.
	if Paths[PlayerName][ID] == nil then
		Player:SendMessage(cChatColor.Rose .. "Path ID does not exist.")
		return true
	end
	
	table.remove(Paths[PlayerName], ID)
	Player:SendMessage("Path " .. ID .. " is removed.")
	return true
end




--[[Allows you to teleport to an waypoint if it exists]]--
function HandleSubCmdTeleport(Split, Player)
	-- ID isn't valid.
	if Split[3] == nil or tonumber(Split[3]) == nil then
		Player:SendMessage(cChatColor.Rose .. "Usage: /path teleport <ID>")
		return true
	end
	
	local ID = tonumber(Split[3])
	local PlayerName = Player:GetName()
	-- Path doesn't exist
	if Paths[PlayerName][ID] == nil then
		Player:SendMessage(cChatColor.Rose .. "Path ID does not exist.")
		return true
	end
	
	local Coordinates = Paths[PlayerName][ID][1]
	Player:TeleportToCoords(Coordinates.x, Coordinates.y, Coordinates.z)
	Player:SendMessage("You teleported to ID:" .. ID .. " X:" .. string.sub(Coordinates.x, 1, string.len(math.floor(Coordinates.x) + 2)) .. " Y:" .. string.sub(Coordinates.y, 1, string.len(math.floor(Coordinates.y) + 2)) .. " Z:" .. string.sub(Coordinates.z, 1, string.len(math.floor(Coordinates.z) + 2)))
	return true
end




--[[Sends the player a message wich says how many waypoints he/she has]]--
function HandleSubCmdNumWP(Split, Player)
	Player:SendMessage("You have " .. #Paths[Player:GetName()] .. " waypoints")
	return true
end




--[[Swaps all the waypoints. The first waypoint becomes the last one the second becomes the second to last one etc.]]--
function HandleSubCmdSwap(Split, Player)
	local PlayerName = Player:GetName()
	local NumWaypoints = #Paths[PlayerName]
	-- Go through half of all the waypoints. If we were to go through everything nothing would change.
	for Idx = 1, NumWaypoints / 2 do
		Paths[PlayerName][Idx], Paths[PlayerName][NumWaypoints - Idx + 1] = Paths[PlayerName][NumWaypoints - Idx + 1], Paths[PlayerName][Idx]
	end
	Player:SendMessage(cChatColor.LightGreen .. "Your waypoints have swapped")
	return true
end
		
