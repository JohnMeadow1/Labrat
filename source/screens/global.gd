extends Node


var doors                   = {"door1": load("res://screens/play/locations/doors/door1.png"),
                               "door2": load("res://screens/play/locations/doors/door2.png"),
                               "door3": load("res://screens/play/locations/doors/door3.png"),
                               "door4": load("res://screens/play/locations/doors/door4.png"),
                               "door5": load("res://screens/play/locations/doors/door5.png"),
                               "door6": load("res://screens/play/locations/doors/door6.png"),
                               "door7": load("res://screens/play/locations/doors/door7.png"),
                               "door8": load("res://screens/play/locations/doors/door8.png")}

var map_pos                     = Vector2(1,3)
var map_orientation             = 0
var map_orientation_vect       = Vector2()
var screen_res                  = Vector2()
var update_res                  = true
var is_clicked                  = false
var mouse_pos                   = Vector2(0,0)
var item_active                 = false
var picked_items                = []
var selected_item_index         = -1
var player_id                   = -1
var compass_orientation         = 0
var compass_target_orientation  = 0
var starting_orientation_offset = 0

var map_packed  = preload("res://screens/play/map/map.tscn")
onready var map = map_packed.instance()

var my_seed = null
var audio = null
func _ready():
	
	screen_res   = OS.get_window_size()
	my_seed = "Godot Rocks"
	seed(my_seed.hash())
	randomize()
	player_id = randi() % 4
#	set_fixed_process(true)
	
func _fixed_process(delta):
	if (OS.get_window_size().x != screen_res.x):
		screen_res = OS.get_window_size()
		update_res = true
		
