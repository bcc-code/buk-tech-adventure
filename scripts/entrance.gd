extends Node2D

@export var map_start_point = false

func _ready():
	load_player.call_deferred()

func load_player():
	# There is always a single global player
	var player = global.player
	# If the player is still attached to something else
	if player.get_parent():
		# Detach the player
		player.get_parent().remove_child(player)
	# ‌The player is supposed to enter here, or the player has no entry point and this is the map's starting point
	if player.entry_point == self.name or (!player.entry_point and map_start_point):
		## Attach the player to the map at this point
		get_parent().add_child.call_deferred(player)
		player.position = position
