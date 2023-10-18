extends AnimatedSprite2D

@export var animation_speed = 20
@export var initial_orientation = 'south'

# There's a trigonometric optimal value that I don't know. This is close enough.
var dead_zone = 0.25
# Save position state for motion calculation
var previous_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	previous_position = get_parent().position
	set_animation(initial_orientation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_position = get_parent().position
	var velocity = delta * (current_position - previous_position)
	var normal = velocity.normalized()
	speed_scale = max(velocity.length() * animation_speed, 0.5)
	play()
	if (normal.x > dead_zone):
		if (normal.y > dead_zone):
			set_animation('southeast')
		elif (normal.y < -dead_zone):
			set_animation('northeast')
		else:
			set_animation('east')
	elif (normal.x < -dead_zone):
		if (normal.y > dead_zone):
			set_animation('southwest')
		elif (normal.y < -dead_zone):
			set_animation('northwest')
		else:
			set_animation('west')
	else:
		if (normal.y > dead_zone):
			set_animation('south')
		elif (normal.y < -dead_zone):
			set_animation('north')
		elif (frame == 0):
			# When no longer movin, the animation continues until it's on the first frame again.
			pause()
	previous_position = current_position
