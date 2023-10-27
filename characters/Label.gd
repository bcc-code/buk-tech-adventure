extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_theme_color_override("font_color", Color(0,0,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.harvested_crops > 0:
		self.text = "Wheat:" + str(global.harvested_crops)

