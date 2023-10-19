extends AnimatedSprite2D

@export var direction = 'south'
@export var current_animation = 'idle'

# There's a trigonometric optimal value that I don't know. This is close enough.
var dead_zone = 0.25
# Save position state for motion calculation
var previous_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	previous_position = get_parent().position
	set_animation(current_animation + '-' + direction)
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_position = get_parent().position
	var velocity = delta * (current_position - previous_position)
	var normal = velocity.normalized()
	var current_frame = frame
	var current_frame_progress = frame_progress
	if (normal.x > dead_zone):
		current_animation = 'walk'
		if (normal.y > dead_zone):
			direction = 'southeast'
		elif (normal.y < -dead_zone):
			direction = 'northeast'
		else:
			direction = 'east'
	elif (normal.x < -dead_zone):
		current_animation = 'walk'
		if (normal.y > dead_zone):
			direction = 'southwest'
		elif (normal.y < -dead_zone):
			direction = 'northwest'
		else:
			direction = 'west'
	else:
		if (normal.y > dead_zone):
			current_animation = 'walk'
			direction = 'south'
		elif (normal.y < -dead_zone):
			current_animation = 'walk'
			direction = 'north'
		elif (current_animation == 'walk' and frame == 0):
			# When no longer moving, the animation continues until it's on the first frame again.
			current_animation = 'idle'
	set_animation(current_animation + '-' + direction)
	# Frame and progress are reset when the animation changes, but in our case, that's wrong.
	set_frame_and_progress(current_frame, current_frame_progress)
	previous_position = current_position
