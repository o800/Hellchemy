extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.force_reload:
		Globals.force_reload = false
		Globals.load_progress()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open cheat console"):
		dev_stuff_REMOVE()

func dev_stuff_REMOVE():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/cheat_console.tscn")
