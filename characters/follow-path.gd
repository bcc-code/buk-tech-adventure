extends PathFollow2D

##‌ Pixels per second
@export var speed=117

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += delta * speed
