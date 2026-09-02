extends Control
@onready var dir = DirAccess.open("user://")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_button_delete_save_pressed() -> void:
	dir.remove("savefile.json")
	


func _on_button_open_save_pressed() -> void:
	str(OS.shell_open(ProjectSettings.globalize_path("user://savefile.json")))


func _on_button_done_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/main.tscn")
	Globals.load_progress()
