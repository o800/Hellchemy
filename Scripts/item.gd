extends Button


var GHOST_ITEM_SCENE = preload("res://Scenes/ghost_item.tscn")

#This variable is necessary because when the item is initially spawned by the list element, button_down signal isn't called
var first = false
@onready var list_element_scene = preload("res://Scenes/list_element.tscn")
@export var item_name: String = ""
# Called when the node enters the scene tree for the first time.
var cancel = false

func _ready() -> void:
	var path_name = "res://Assets/ItemImages/" + item_name.to_lower() + ".png"
	if FileAccess.file_exists(path_name):	
		$TextureRect.texture = load("res://Assets/ItemImages/" + item_name.to_lower() + ".png")
	#global_position = get_global_mouse_position()
	$Label.text = item_name

var drag_offset = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button_pressed or (first and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		global_position = get_global_mouse_position() + drag_offset
		$AnimationPlayer.stop()
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and first:
		first = false
		emit_signal("button_up")
	
		



#Checks if the item is overlapping with other items. If it is, it will attempt a craft and the function will exit.
func check_overlapping():
	#[DEPRECATED] 
	#Check if it is on the trash can, destroy if it is 
	#if get_global_rect().intersects(self.get_parent().get_parent().find_child("TrashCan").get_global_rect()):
	#	queue_free()
	var nodes = self.get_parent().get_children() # Items Control Node
	nodes.reverse()
	for item: Button in nodes:
		if item == self:
			continue
		
		# Detect collision
		var rect1 = item.get_global_rect()
		var rect2 = get_global_rect()
		print("Rect 2: ", rect2, "\nRect1", rect1)
		if rect1.intersects(rect2):
			craft_and_create(item)
			return
			

# Will use self as the first item. Will not do anything if the input item doesn't make a valid recipe. If the recipe is valid, this node and the node passed in will be destroyed and a new item will be created.
func craft_and_create(second_item):
	if not Globals.is_valid_recipe(second_item.item_name, item_name):
		var items = [second_item, self]
		var effect = func effect(v: Node):
			v.get_node("Label").add_theme_color_override("font_color", Color.RED)
			await get_tree().create_timer(0.4).timeout
			v.get_node("Label").add_theme_color_override("font_color", Color.WHITE)
		for v in items:
			effect.call(v)
	var crafted_item = Globals.combine(second_item.item_name, item_name)
	print("CRAFTED: ", crafted_item)
	if crafted_item:
		
		# Create the item
		Globals.create_item(crafted_item, position)
		
		#check if item is already discovered
		#if it's not, find where it goes in the listd
		print(Globals.is_item_discovered(crafted_item))
		print(Globals.discovered_items)
		
		if !Globals.is_item_discovered(crafted_item):
			Globals.discover(crafted_item)
			
		
		# Destroy the two items that formed the new item
		second_item.queue_free()
		queue_free()
	else:
		$AnimationPlayer.play("fail")
		if Globals.is_recipe_discovered(item_name, second_item.item_name):
			var midpoint_vector = (position + second_item.position) / 2 + Vector2(0,-65)
			var instance = GHOST_ITEM_SCENE.instantiate()
			instance.global_position = midpoint_vector
			instance.item_name = Globals.get_resulting_item(item_name, second_item.item_name)
			$"../../".add_child(instance)
	
func _on_button_up() -> void:
	first = false
	if cancel:
		cancel = false
	else:
		check_overlapping()
	#if the item is dropped in the list, delete it
	if global_position.x+32 > $"../../ColorRect".position.x:
		queue_free()

func _on_button_down() -> void:
	#move the node to the last position putting it at the top visually
	get_parent().move_child(self, -1)
	
	drag_offset = global_position - get_global_mouse_position()	
	
	if $DoubleclickTimer.time_left > 0:
		$DoubleclickTimer.stop()
		cancel = true
		Globals.create_item(item_name, global_position + Vector2(10,-10))
	else:
		$DoubleclickTimer.start()
	
	
	
