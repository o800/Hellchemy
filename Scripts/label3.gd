extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_settings = LabelSettings.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label_settings.font_size = Globals.ui_scale * 16
