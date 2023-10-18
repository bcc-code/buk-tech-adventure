extends CharacterBody2D

const MOTION_SPEED = 234 # Pixels/second, 1 tile = 234 pixels
const FRICTION_FACTOR = 0.75

func _physics_process(_delta):
	var motion = Input.get_vector("move_west", "move_east", "move_north", "move_south")
	# The isometric tiles y/x aspect is 1/2, so we must scale the motion by that factor
	motion.y /= 2
	velocity += motion.normalized() * MOTION_SPEED
	# Apply friction.
	velocity *= FRICTION_FACTOR
	move_and_slide()
