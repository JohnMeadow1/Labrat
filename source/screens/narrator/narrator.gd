extends Node2D

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	get_node("Camera2D").set_pos(get_viewport().get_mouse_pos())
#	get_node("TextureFrame/Control/Viewport").set_rect(Rect2(Vector2(),GLOBAL.screen_res))
	