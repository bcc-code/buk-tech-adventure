extends AnimatedSprite2D

var previous_position = Vector2()
var dead_zone = 0.25
var speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	previous_position = get_parent().position
	set_animation('south')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_position = get_parent().position
	var motion = delta * (current_position - previous_position)
	var normal = motion.normalized()
	speed_scale = max(motion.length() * speed, 0.5)
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
			pause()
	previous_position = current_position
