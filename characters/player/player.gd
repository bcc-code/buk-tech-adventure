extends CharacterBody2D

## In pixels / second
@export var player_speed = 234
## Friction is per frame. You may slide weirdly on very low FPS
@export var friction = 0.75
## Difference in direction (degrees) between input direction and movement direction.
@export var input_offset_angle = 45

func _physics_process(_delta):
	var motion = Input.get_vector("move_west", "move_east", "move_north", "move_south").rotated(deg_to_rad(input_offset_angle))
	# The isometric tiles y/x aspect is 1/2, so we must scale the motion by that factor
	motion.y /= 2
	# No delta factor required, move_and_slide already does that!
	velocity += motion.normalized() * player_speed
	# Apply friction.
	velocity *= friction
	move_and_slide()
