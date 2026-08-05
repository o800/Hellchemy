extends Button

var first = true

@export var item_name: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = load("res://Assets/ItemImages/" + item_name.to_lower() + ".jpg")
	global_position = get_global_mouse_position()
	$Label.text = item_name

var drag_offset = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button_pressed or (first and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		global_position = get_global_mouse_position() + drag_offset
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and first:
		first = false
		check_overlapping()


		
func check_overlapping():
	for item: Button in self.get_parent().get_children():
		if item == self:
			continue
		var rect1 = item.get_global_rect()
		var rect2 = get_global_rect()
		print("Rect 2: ", rect2, "\nRect1", rect1)
		if rect1.intersects(rect2):
			print("INTERSECTING")
	
func _on_button_up() -> void:
	first = false
	check_overlapping()

func _on_button_down() -> void:
	drag_offset = global_position - get_global_mouse_position()
	
