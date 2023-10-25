extends Area2D

@export var slowdown = 50
@export var time = 5

func _ready():
	connect("body_entered", body_entered)
	
func body_entered(character):
	if ('speed' in character):
		character.speed -= slowdown
		await get_tree().create_timer(time).timeout
		character.speed += slowdown
