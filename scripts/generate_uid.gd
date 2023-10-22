extends Node

# Generates a single UID on start. Useful if you copy and paste a file that has an internal UID that must be unique, such as the .tres files.
func _ready():
	print(ResourceUID.id_to_text(ResourceUID.create_id()))
