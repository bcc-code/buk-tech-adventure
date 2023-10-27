extends CharacterBody2D

## In pixels / second
@export var speed = 234
## Slide factor is calculated per frame. You may slide weirdly on very low FPS
@export var slide_factor = 0.75
## Difference in direction (degrees) between input direction and movement direction.
@export var input_offset_angle = 45
## Floor constraint
@export var movement_constraint: Node

var entry_point: String
var farmer_in_range = false
var crops_to_harvest = []

func _ready():
	global.player = self

func _physics_process(_delta):
	if Input.is_action_just_released("interact"):
		if  farmer_in_range:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/farmer.dialogue"), "farmer")
		elif len(crops_to_harvest) > 0 && global.quest_status == "STARTED":
			for crop in crops_to_harvest:
				crop.harvest()
	var motion = Input.get_vector("move_west", "move_east", "move_north", "move_south").rotated(deg_to_rad(input_offset_angle))
	# The isometric tiles y/x aspect is 1/2, so we must scale the motion by that factor
	motion.y /= 2
	# No delta factor required, move_and_slide already does that!
	velocity += motion.normalized() * speed
	# Apply friction.
	velocity *= slide_factor
	if movement_constraint:
		movement_constraint.stay_within_collision(self)
	move_and_slide()

func _on_detection_area_body_entered(body):
	print(body)
	if body.has_method("farmer"):	
		farmer_in_range = true
	if body.has_method("harvest"):
		crops_to_harvest.append(body)


func _on_detection_area_body_exited(body):
	if body.has_method("farmer"):
		farmer_in_range = false
	if body.has_method("harvest") && crops_to_harvest.has(body):
		crops_to_harvest.erase(body)
