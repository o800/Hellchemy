extends Node
var json = JSON.new()
var discovered_recipes: Dictionary
var items_container: Node = null
var list_element_container: Node = null

@onready var item_scene = preload("res://Scenes/item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	json.parse(FileAccess.open("res://Assets/recipes.json", FileAccess.READ).get_as_text())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

#The return type of Variant is being used as an option here. 
func combine(item1: String, item2: String) -> Variant:
	#order items alphabetically
	if item2 < item1:
		var tmp = item2
		item2 = item1
		item1 = tmp
	#check if recipe is discovered already
	if is_recipe_discovered(item1,item2):
		return null
		
	if json.data.has(item1):
		if json.data[item1].has(item2):
			#mark recipe as discovered
			discovered_recipes[item1] = {item2:true}
			
			return json.data[item1][item2]
	return null
	

func is_recipe_discovered(item1, item2):
	if item2 < item1:
		var tmp = item2
		item2 = item1
		item1 = tmp
	if discovered_recipes.has(item1):
		if discovered_recipes[item1].has(item2):
			if discovered_recipes[item1][item2] == true:
				return true	
	return false

func create_item(item_name: String, position: Vector2):
	var item: Button = item_scene.instantiate()
	item.position = position
	item.item_name = item_name
	items_container.add_child(item)
