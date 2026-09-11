extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	var command = $TextEdit.text.strip_edges().to_lower()
	if command == "back":
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/main.tscn")
