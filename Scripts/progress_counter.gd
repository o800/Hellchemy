extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$RecipeLabel.text = str(Globals.number_of_discovered_recipes) + "/" + str(Globals.total_recipes) + " recipes discovered"
	$ItemLabel.text = str(len(Globals.list_element_container.get_children())) + "/" + str(len(Globals.unique_items)) + " items discovered"
