extends Node

var map_pos                     = Vector2(5,5)
var map_orientation             = 0
var screen_res                  = Vector2()
var update_res                  = true
var is_clicked                  = false


var map_packed = preload("res://screens/play/map/map.tscn")
onready var map = map_packed.instance()

func _ready():
	screen_res   = OS.get_window_size()
	
#	set_fixed_process(true)
	
func _fixed_process(delta):
	
	if (OS.get_window_size().x != screen_res.x):
		screen_res = OS.get_window_size()
		update_res = true