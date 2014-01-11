
-- Info.lua

-- Implements the g_PluginInfo standard plugin description




function GetPluginInfo()
	return
	{
		Name = "Paths",
		Date = "2014-1-11",
		Description =
	[[
	This plugin allows users to fly through a given path smoothly
	]],
		Commands =
		{
			["/path"] =
			{
				Permission = "",
				HelpString = "",
				Handler = nil,
				Subcommands =
				{
					add =
					{
						HelpString = "This adds a waypoint to your path",
						Permission = "path.add",
						Handler = HandleSubCmdAdd,
					},
					clear =
					{
						HelpString = "Stops your path and clears it.",
						Permission = "path.clear",
						Handler = HandleSubCmdClear,
					},
					remove =
					{
						HelpString = "Removes the given path ID",
						Permission = "path.remove",
						Handler = HandleSubCmdRemove,
						ParameterCombination =
						{
							{
								Params = "PathID",
								Help = "The ID that will be removed.",
							},
						},
					},
					replace =
					{
						HelpString = "Replaces the given path ID with the position you are currently standing.",
						Permission = "path.replace",
						Handler = HandleSubCmdReplace,
						ParameterCombinations =
						{
							{
								Params = "PathID",
								Help = "The ID you want to replace",
							},
						},
					},
					numwp =
					{
						HelpString = "Sends the amount of waypoints your path holds.",
						Permission = "path.numwp",
						Handler = HandleSubCmdNumWP,
					},
					start =
					{
						HelpString = "Teleports you to the first waypoint and then moves you smoothly through them.",
						Permission = "path.start",
						Handler = HandleSubCmdStart,
						ParameterCombinations =
						{
							{
								Params = "Speed",
								Help = "The speed you move through the waypoints",
							},
						},
					},
					stop =
					{
						HelpString = "Stops your path.",
						Permission = "path.stop",
						Handler = HandleSubCmdStop,
					},
					swap =
					{
						HelpString = "Swaps all your waypoints. The first becomes the last etc",
						Permission = "path.swap",
						Handler = HandleSubCmdSwap,
					},
					teleport =
					{
						HelpString = "Teleports you to the given path",
						Permission = "path.teleport",
						Handler = HandleSubCmdTeleport,
						ParameterCombinations =
						{
							{
								Params = "PathID",
								Help = "The path ID you want to teleport to",
							},
						},
					},
				},
			},
		},
	}
end

			