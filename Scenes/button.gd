extends Button
var dir

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir = DirAccess.open("user://")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	dir.remove("savefile.json")
	Globals.discovered_items.clear()
	Globals.discovered_recipes.clear()
	for i in Globals.list_element_container.get_children():
		i.queue_free()
	Globals.total_recipes = 0
	Globals.number_of_discovered_recipes = 0
	Globals.unique_items.clear()
	Globals._ready()
