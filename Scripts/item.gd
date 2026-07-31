extends Control

var move = true
@export var item_name: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = load("res://Assets/ItemImages/" + item_name.to_lower() + ".jpg")
	global_position = get_global_mouse_position()
	$Label.text = item_name

var drag_offset = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move:
		global_position = get_global_mouse_position() + drag_offset
	
	


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		move_to_front()
		drag_offset = global_position - get_global_mouse_position()
		move = true
	if event.is_action_released("click"):
		move = false		
