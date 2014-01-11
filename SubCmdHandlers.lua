function HandleSubCmdAdd(Split, Player)
	local PlayerName = Player:GetName()
	if Paths[PlayerName] == nil then
		Paths[PlayerName] = {}
	end
	table.insert(Paths[PlayerName], {Vector3f(Player:GetPosition()), Vector3f(Player:GetRot())})
	Player:SendMessage("New path added NR:" .. #Paths[PlayerName] .. " X:" .. string.sub(Player:GetPosX(), 1, string.len(math.floor(Player:GetPosX())) + 2) .. " Y:" .. string.sub(Player:GetPosY(), 1, string.len(math.floor(Player:GetPosY())) + 2) .. " Z:" .. string.sub(Player:GetPosZ(), 1, string.len(math.floor(Player:GetPosZ())) + 2))
	return true
end

function HandleSubCmdClear(Split, Player)
	local PlayerName = Player:GetName()
	CurrentPath[PlayerName] = -1
	Paths[PlayerName] = {}
	Player:SendMessage(cChatColor.LightGreen .. "Paths are cleared")
	return true
end

function HandleSubCmdStart(Split, Player)
	local PlayerName = Player:GetName()
	if Split[3] == nil or tonumber(Split[3]) == nil then
		Player:SendMessage("Usage: /path Start <Speed>")
		return true
	end
	if #Paths[PlayerName] < 1 then
		Player:SendMessage("You don't have any paths set up")
		return true
	end
	CurrentPath[PlayerName] = 1
	Player:TeleportToCoords(Paths[PlayerName][1][1].x, Paths[PlayerName][1][1].y, Paths[PlayerName][1][1].z)
	Player:SetRot(Paths[PlayerName][1][2])
	MaxSpeed[PlayerName] = tonumber(Split[3])
	Player:SendMessage(cChatColor.LightGreen .. "Path Started")
	return true
end

function HandleSubCmdStop(Split, Player)
	CurrentPath[Player:GetName()] = -1
	Player:SendMessage(cChatColor.Red .. "Path stopped")
	return true
end

function HandleSubCmdReplace(Split, Player)
	if Split[3] == nil or tonumber(Split[3]) == nil then
		Player:SendMessage(cChatColor.Rose .. "Usage: /path replace <ID>")
		return true
	end
	local ID = tonumber(Split[3])
	local PlayerName = Player:GetName()
	if Paths[PlayerName][ID] == nil then
		Player:SendMessage(cChatColor.Rose .. "Path ID does not exist.")
		return true
	end
	Paths[PlayerName][ID] = {Vector3f(Player:GetPosition()), Vector3f(Player:GetRot())}
	Player:SendMessage("Path " .. ID .. " is replaced. New coordinates are: " .. "X:" .. string.sub(Player:GetPosX(), 1, string.len(math.floor(Player:GetPosX())) + 2) .. " Y:" .. string.sub(Player:GetPosY(), 1, string.len(math.floor(Player:GetPosY())) + 2) .. " Z:" .. string.sub(Player:GetPosZ(), 1, string.len(math.floor(Player:GetPosZ())) + 2))
	return true
end