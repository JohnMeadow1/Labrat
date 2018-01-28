extends Node2D

func _ready():
	set_fixed_process(true)
	if randi()%2:
		get_node("RichTextLabel1").set_hidden(true)
	else:
		get_node("RichTextLabel0").set_hidden(true)
	get_node("SamplePlayer").play("radio1")

func _fixed_process(delta):
	get_node("Camera2D").set_pos(get_viewport().get_mouse_pos())
#	get_node("TextureFrame/Control/Viewport").set_rect(Rect2(Vector2(),GLOBAL.screen_res))
	