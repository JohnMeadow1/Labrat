extends Control

var s = load("res://screens/title/title.tscn")

func _ready():
#	set_aspect()
	pass
	
func change_to_next_scene( button_idx = 0, scene = s ):
#	print(button_idx)
	GLOBAL.current_level = button_idx + 1
	if typeof(scene) == TYPE_STRING:
		get_tree().change_scene(scene)
	else:
#		get_tree().change_scene(scene.get_path())
		get_tree().change_scene_to(scene)

func set_aspect():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_IGNORE, Vector2())
