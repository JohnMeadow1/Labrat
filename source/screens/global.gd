extends Node


var map_pos                     = Vector2(1,3)
var map_orientation             = 0
var map_orientation_vect        = Vector2()
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

var passwords = { "Isolation_S1_0":    "4426",
                  "Isolation_S1_1":    "1937",
                  "Isolation_S1_2":    "3691",
                  "Isolation_S2_0":    "6108",
                  "Isolation_S2_1":    "9225",
                  "Isolation_S2_2":    "1165",
                  "Isolation_S3_0":    "1277",
                  "Isolation_S3_1":    "5636",
                  "Isolation_S3_2":    "1155",
                  "Isolation_S4_0":    "2223",
                  "Isolation_S4_1":    "5876",
                  "Isolation_S4_2":    "4560",
                  "Corridor_0":        "4444",
                  "Decontamination_0": "4735",
                  "Decontamination_1": "8631",
                  "Decontamination_2": "9531",
                  "Archive_0":         "4587",
                  "Archive_1":         "5941",
                  "Archive_2":         "1267",
                  "Warehouse_0":       "9754",
                  "Warehouse_1":       "8345",
                  "Warehouse_2":       "8748",
                  "Lab_0":             "5563", 
                  "Lab_1":             "9981", 
                  "Lab_2":             "7861", 
                  "Animal_testing_0":  "6531", 
                  "Animal_testing_1":  "8316", 
                  "Animal_testing_2":  "7831", 
                  "Study_room_0":      "8541", 
                  "Study_room_1":      "3256", 
                  "Study_room_2":      "8653" } 

var map_packed  = preload("res://screens/play/map/map.tscn")
onready var map = map_packed.instance()

var my_seed   = null
var audio     = null
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
		
