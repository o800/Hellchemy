extends Node
var json = JSON.new()
var discovered_recipes: Dictionary
var recipe_counter = 0
var items_container: Node = null
var list_element_container: Node = null
var discovered_items: Array


@onready var item_scene = preload("res://Scenes/item.tscn")
@onready var list_element_scene = preload("res://Scenes/list_element.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	if FileAccess.file_exists("user://savefile.json"):
		load_progress()
	else:
		var starters = JSON.new()
		starters.parse(FileAccess.open("res://Assets/starters.json", FileAccess.READ).get_as_text())
		for i in starters.data:
			discover(i)
		save_progress()
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
			recipe_counter += 1
			if !discovered_recipes.has(item1):
				discovered_recipes[item1] = {}
			if !discovered_recipes[item1].has(item2):
				discovered_recipes[item1][item2] = true
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
	return item


func is_item_discovered(item):
	if discovered_items.has(item):
		return true
	return false
	
	
	
	
func save_progress():
	var savefile = FileAccess.open("user://savefile.json", FileAccess.WRITE)
	var savedata: Dictionary
	discovered_items.sort()
	savedata["items"] = discovered_items
	savedata["recipes"] = discovered_recipes
	savefile.store_string(JSON.stringify(savedata))


func load_progress():
	var savefile = FileAccess.open("user://savefile.json", FileAccess.READ)
	var savedata = JSON.new()
	savedata.parse(savefile.get_as_text())
	for item in savedata.data["items"]:
		discover(item)
	discovered_recipes = savedata.data["recipes"]
	
	
func discover(item):
	discovered_items.push_back(item)
	print(item)
	
	var max = Globals.list_element_container.get_child_count()
	var min = 0
	while(max-min>0):	
		print((max-min)/2+min)
		if Globals.list_element_container.get_child((max-min)/2+min).item_name > item:
			max = (max-min)/2 + min -1
		elif Globals.list_element_container.get_child((max-min)/2+min).item_name < item:
			min = (max-min)/2 + min +1
		else:
			print("warning, invalid state reached")
			break
			
	# Add the corresponding list element to the list of items discovered
	var list_element = list_element_scene.instantiate()
	list_element.item_name = item
	Globals.list_element_container.add_child(list_element)
		
	#move it to the right spot
	Globals.list_element_container.move_child(list_element, min)
	
