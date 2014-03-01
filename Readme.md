This plugin allows users to fly through a given path smoothly by placing waypoints in the world. When the player then uses "/path start" the plugin starts guiding/pushing the player in the way of the next waypoint. This is usefull for for example recording. A player can set out a path then start recording, and the server will do the moving while the player can enjoy the sightseeing. 

# Commands

## General


### /path add
This adds a waypoint to your path

Permission required: **path.add**


### /path clear
Stops your path and clears it.

Permission required: **path.clear**


### /path numwp
Sends the amount of waypoints your path holds.

Permission required: **path.numwp**


### /path remove
Removes the given path ID

Permission required: **path.remove**


### /path replace
Replaces the given path ID with the position you are currently standing.

Permission required: **path.replace**

The following parameter combinations are recognized:

`/path replace PathID` - The ID you want to replace

### /path start
Teleports you to the first waypoint and then moves you smoothly through them.

Permission required: **path.start**

The following parameter combinations are recognized:

`/path start Speed` - The speed you move through the waypoints

### /path stop
Stops your path.

Permission required: **path.stop**


### /path swap
Swaps all your waypoints. The first becomes the last etc

Permission required: **path.swap**


### /path teleport
Teleports you to the given path

Permission required: **path.teleport**

The following parameter combinations are recognized:

`/path teleport PathID` - The path ID you want to teleport to



# Permissions
### path.add


Commands affected:
  - `/path add`

### path.clear


Commands affected:
  - `/path clear`

### path.numwp


Commands affected:
  - `/path numwp`

### path.remove


Commands affected:
  - `/path remove`

### path.replace


Commands affected:
  - `/path replace`

### path.start


Commands affected:
  - `/path start`

### path.stop


Commands affected:
  - `/path stop`

### path.swap


Commands affected:
  - `/path swap`

### path.teleport


Commands affected:
  - `/path teleport`

