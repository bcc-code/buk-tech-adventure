extends Area2D

@export_file("*.tscn") var to_scene: String
@export var entrance_name: String

func _ready():
	connect("body_entered", body_entered)
	if !to_scene:
		$sprite.animation = "none"
		$sprite.play()

func body_entered(_body: Node2D):
	var player = global.player
	player.entry_point = entrance_name
	# Decouple player from current scene, so it is not erased on scene change
	player.get_parent().remove_child(player)
	get_tree().change_scene_to_file(to_scene)
