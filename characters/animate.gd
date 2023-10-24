extends AnimatedSprite2D

## Node used to get position
@export var location_parent: CharacterBody2D
@export var direction = 'south'
@export var idle_speed_maximum = 0.01
@export var idle_animation_prefix = 'idle'
@export var move_animation_prefix = 'walk'

var current_animation = 'idle'

# Save position state for motion calculation
var previous_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	previous_position = location_parent.position
	set_animation(current_animation + '-' + direction)
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_position = location_parent.position
	var velocity = delta * (current_position - previous_position)
	var speed = velocity.length()
	var current_frame = frame
	var current_frame_progress = frame_progress
	if speed > idle_speed_maximum:
		current_animation = move_animation_prefix
		# Map velocity angle to circle segment from 0 (northwest) clockwise to 7 (west)
		match int(ceil(velocity.angle() * 8 / TAU - 0.5)) + 3:
			0: direction = 'northwest'
			1: direction = 'north'
			2: direction = 'northeast'
			3: direction = 'east'
			4: direction = 'southeast'
			5: direction = 'south'
			6: direction = 'southwest'
			7: direction = 'west'
	elif (frame == 0):
		current_animation = idle_animation_prefix
	var previous_animation = animation
	animation = current_animation + '-' + direction
	if (previous_animation.begins_with(current_animation)):
		# Frame and progress are reset when the animation changes.
		# We don't want that when only the direction part changes.
		set_frame_and_progress(current_frame, current_frame_progress)
	previous_position = current_position
