extends Node2D

var player: CharacterBody2D
var harvested_crops = 0

# quest_status : "NONE" | "STARTED" | "FINISHED"
var quest_status = "NONE"

func _read():
	player = $player
