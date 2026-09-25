extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_text_changed(new_text: String) -> void:
	for i in $"../ScrollContainer/ListElementContainer".get_children():
		i.visible = i.item_name.to_lower().contains(text.to_lower()) || text == ""
 	
