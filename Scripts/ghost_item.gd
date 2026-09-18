extends TextureRect

@export var item_name: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var path_name = "res://Assets/ItemImages/" + item_name.to_lower() + ".png"
	if FileAccess.file_exists(path_name):	
		texture = load("res://Assets/ItemImages/" + item_name.to_lower() + ".png")
	$Label.text = item_name
	get_tree().create_tween().tween_property(self, "position", position + Vector2(0, -100), 1.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	get_tree().create_tween().tween_property(self, "self_modulate:a", 0, 1.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	get_tree().create_tween().tween_property($Label, "self_modulate:a", 0, 1.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
