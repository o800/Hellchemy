extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#The marker is at y = 1.3 at base ui scale and is positioned with a control node, so this finds the current UI scale
	Globals.ui_scale = $Marker2D.global_position.y / 1.3
