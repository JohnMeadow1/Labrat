extends "res://screens/abstract_screen.gd"
var blob = preload("res://screens/title/actors/blob.tscn")

func _ready():
	set_fixed_process(true)
	get_node("TextureFrame/Control/Viewport").set_rect(Rect2(Vector2(),GLOBAL.screen_res))
	get_node("TextureFrame/Control/ViewportSprite").get_material().set_shader_param( "target_color", Color(0,0,0,1) )
	get_node("TextureFrame/Control/ViewportSprite").get_material().set_shader_param( "target_alpha", 0.5 )
	get_node("TextureFrame/MarginContainer/HBoxContainer/Play").connect("released", self, "change_to_next_scene", [0,"res://screens/play/main.tscn"])
	generate_blobs( 20 )

func _fixed_process(delta):
	get_node("TextureFrame/Control/Viewport").set_rect(Rect2(Vector2(),GLOBAL.screen_res))

func generate_blobs( count ):
	for i in range(count):
		get_node("TextureFrame/Control/Viewport").add_child(blob.instance())
	