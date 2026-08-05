extends Node
var json = JSON.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	json.parse(FileAccess.open("res://Assets/recipes.json", FileAccess.READ).get_as_text())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func combine(item1: String, item2: String):
	if item2 < item1:
		var tmp = item2
		item2 = item1
		item1 = tmp
	
	if json.data.has(item1):
		if json.data[item1].has(item2):
			return json.data[item1][item2]
	return null
