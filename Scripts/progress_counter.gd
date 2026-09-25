extends Control
var settings = LabelSettings.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RecipeLabel.label_settings = settings
	$ItemLabel.label_settings = settings

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$RecipeLabel.text = str(Globals.number_of_discovered_recipes) + "/" + str(Globals.total_recipes) + " recipes discovered"
	$ItemLabel.text = str(len(Globals.list_element_container.get_children())) + "/" + str(len(Globals.unique_items)) + " items discovered"
	settings.font_size = Globals.ui_scale * 32
