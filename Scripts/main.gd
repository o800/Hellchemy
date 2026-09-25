extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.force_reload:
		Globals.force_reload = false
		Globals.total_recipes = 0
		Globals.number_of_discovered_recipes = 0
		Globals.recipe_counter = 0
		Globals.discovered_items.clear()
		Globals.discovered_recipes.clear()
		Globals._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open cheat console"):
		dev_stuff_REMOVE()

func dev_stuff_REMOVE():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/cheat_console.tscn")
