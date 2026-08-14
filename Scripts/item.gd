extends Button

# This variable is necessary because when the item is initially spawned by the list element, button_down signal isn't called
var first = true
@onready var list_element_scene = preload("res://Scenes/list_element.tscn")
@export var item_name: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = load("res://Assets/ItemImages/" + item_name.to_lower() + ".jpg")
	#global_position = get_global_mouse_position()
	$Label.text = item_name

var drag_offset = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button_pressed or (first and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		global_position = get_global_mouse_position() + drag_offset
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and first:
		first = false
		emit_signal("button_up")
	
		


# Checks if the item is overlapping with other items. If it is, it will attempt a craft and the function will exit.
func check_overlapping():
	for item: Button in self.get_parent().get_children():
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
	var crafted_item = Globals.combine(second_item.item_name, item_name)
	print("CRAFTED: ", crafted_item)
	# Check if this is a valid recipe
	if crafted_item:
		
		# Create the item
		Globals.create_item(crafted_item, position)
		
		#check if item is already discovered
		var is_discovered = false
		for i in Globals.list_element_container.get_children():
			if i.item_name == crafted_item:
				is_discovered = true
		#if it's not, find where it goes in the list
		if !is_discovered:
			var max = Globals.list_element_container.get_child_count()
			var min = 0
			while(max-min>0):	
				print((max-min)/2+min)
				if Globals.list_element_container.get_child((max-min)/2+min).item_name > crafted_item:
					max = (max-min)/2 + min -1
				elif Globals.list_element_container.get_child((max-min)/2+min).item_name < crafted_item:
					min = (max-min)/2 + min +1
				else:
					print("warning, invalid state reached")
					pass
					
			# Add the corresponding list element to the list of items discovered
			var list_element = list_element_scene.instantiate()
			list_element.item_name = crafted_item
			Globals.list_element_container.add_child(list_element)
			
			#move it to the right spot
			Globals.list_element_container.move_child(list_element, min)
		
		# Destroy the two items that formed the new item
		second_item.queue_free()
		queue_free()
	
func _on_button_up() -> void:
	first = false
	check_overlapping()
	if global_position.x > Globals.list_element_container.global_position.x:
		queue_free()

func _on_button_down() -> void:
	#move the node to the last position putting it at the top visually
	get_parent().move_child(self, -1)
	
	drag_offset = global_position - get_global_mouse_position()	
	
