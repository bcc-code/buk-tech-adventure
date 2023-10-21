extends Node

## The collision mask
@export_flags_2d_physics var constrain_to_layers = 0
## Use a higher value if you start sliding out of collision area. Too high values may make the game run slow.
@export var collision_iteration_max_depth = 3
## In pixels
@export var minimum_check_distance = 16
## In pixels
@export var maximum_check_distance = 32

func stay_within_collision(character):
	for i in collision_iteration_max_depth:
		var ray = PhysicsRayQueryParameters2D.create(character.global_position + character.velocity.normalized() * minimum_check_distance, character.global_position + character.velocity.normalized() * maximum_check_distance, constrain_to_layers)
		ray.hit_from_inside = true
		var collision = character.get_world_2d().direct_space_state.intersect_ray(ray)
		if collision:
			# Object stays within the collision layer
			break
		# Object leaves the collision layer, raycast back to get the normal.
		var reverse_collision = character.get_world_2d().direct_space_state.intersect_ray(PhysicsRayQueryParameters2D.create(character.global_position + character.velocity.normalized() * maximum_check_distance, character.global_position, constrain_to_layers))
		if !reverse_collision:
			# Object is already outside the collision layer. This is bad. Stop all movement.
			character.velocity = Vector2.ZERO
			break
		# Movement will cause object to leave collision layer, remove the velocity component that causes movement towards the collision layer edge.
		character.velocity -= character.velocity.project(reverse_collision.normal)
