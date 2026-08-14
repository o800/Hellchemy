extends Button



@onready var item_scene = preload("res://Scenes/item.tscn")
@export var item_name = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item_name == "":
		queue_free()
	#$HBoxContainer.pre_sort_children.connect(func():
		#var font: Font = $HBoxContainer/Label.get_theme_font("font")
		#var font_size = floor($HBoxContainer/Label.size.y)
		#var text_size = Vector2.ZERO
	#
		#while true:
			#text_size = font.get_string_size($HBoxContainer/Label.text,HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
			#if text_size.x > size.x:
				## And if it's bigger, lower the font size and try again
				#font_size -= 5
			#else:
				#break
		#$HBoxContainer/Label.add_theme_font_size_override("font_size", font_size)
		#$HBoxContainer.fit_child_in_rect($HBoxContainer/Label, Rect2(Vector2.ZERO, $HBoxContainer.size))
	#)
	$HBoxContainer/Label.text = item_name
	$HBoxContainer/TextureRect.texture = load("res://Assets/ItemImages/" + item_name.to_lower() + ".jpg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



	
	


func _on_button_down() -> void:
	Globals.create_item(item_name, get_global_mouse_position()).first = true
