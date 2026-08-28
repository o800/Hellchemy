extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in self.get_children():
		x.self_modulate.a = 0
	for x in self.get_children():
		get_tree().create_tween().tween_property(x, "self_modulate:a", 1, 1)
	await get_tree().create_timer(0.8 + 1.5).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
