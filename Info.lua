
-- Info.lua

-- Implements the g_PluginInfo standard plugin description





g_PluginInfo =
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
			},
		},
	},
}

		