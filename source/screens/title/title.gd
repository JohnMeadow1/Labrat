extends "res://screens/abstract_screen.gd"
var blob = preload("res://screens/title/actors/blob.tscn")

func _ready():
#	GLOBAL.color_array = [Color(.39,.68,.21),Color(1,1,.32),Color(.98,.6,.07),Color(1,.15,.07),Color(.51,0,.65),Color(.07,.27,.98)]
	set_fixed_process(true)
	get_node("TextureFrame/Control/Viewport").set_rect(Rect2(Vector2(),GLOBAL.screen_res))
	get_node("TextureFrame/Control/ViewportSprite").get_material().set_shader_param( "target_color", Color(0,0,0,1) )
	get_node("TextureFrame/Control/ViewportSprite").get_material().set_shader_param( "target_alpha", 0.5 )
#	get_node("TextureFrame/Control/Viewport").set_as_render_target(true)
	get_node("TextureFrame/MarginContainer/HBoxContainer/Play").connect("released", self, "change_to_next_scene", [0,"res://screens/select_level/select_level.tscn"])
	generate_blobs( 20 )

func _fixed_process(delta):
	get_node("TextureFrame/Control/Viewport").set_rect(Rect2(Vector2(),GLOBAL.screen_res))
#	self.set_scale( Vector2(GLOBAL.viewport_scale, GLOBAL.viewport_scale) )
#	self.set_scale(self.get_scale() / GLOBAL.viewport_scale)

func generate_blobs( count ):
	for i in range(count):
		get_node("TextureFrame/Control/Viewport").add_child(blob.instance())
	