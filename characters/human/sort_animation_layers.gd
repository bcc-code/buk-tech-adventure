extends Node

## Animatable left-hand sprite
@export var left_hand_child: AnimatedSprite2D
## Animatable body sprite
@export var body_child: AnimatedSprite2D
## Animatable right-hand sprite
@export var right_hand_child: AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sort_children(body_child.animation)

## Sort the children so the sprites are layered correctly
func sort_children(animation: String):
		if (animation.ends_with('east')):
			move_child(body_child, 0)
			move_child(left_hand_child, 0)
		elif (animation.ends_with('west')):
			move_child(body_child, 0)
			move_child(right_hand_child, 0)
		elif (animation.ends_with('north')):
			move_child(left_hand_child, 0)
			move_child(right_hand_child, 0)
		elif (animation.ends_with('south')):
			move_child(left_hand_child, 0)
			move_child(body_child, 0)

func hit():
	body_child.current_animation = 'hit'
	right_hand_child.current_animation = 'hit'
	left_hand_child.current_animation = 'hit'

func attack():
	body_child.current_animation = 'attack'
	right_hand_child.current_animation = 'attack'
	left_hand_child.current_animation = 'attack'
