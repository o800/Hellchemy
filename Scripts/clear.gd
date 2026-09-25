extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	add_theme_font_size_override("font_size", 16 * Globals.ui_scale)


func _on_pressed() -> void:
	for child in %Items.get_children():
		child.free()
