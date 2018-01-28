tool
extends Node2D

var grid                    = []
var walls                   = {"wall": load("res://screens/play/locations/wall.png"),
                               "deep_wall": load("res://screens/play/locations/corridor.png")}

var doors                   = {"door1": load("res://screens/play/locations/doors/door1.png"),
                               "door2": load("res://screens/play/locations/doors/door2.png"),
                               "door3": load("res://screens/play/locations/doors/door3.png"),
                               "door4": load("res://screens/play/locations/doors/door4.png"),
                               "door5": load("res://screens/play/locations/doors/door5.png"),
                               "door6": load("res://screens/play/locations/doors/door6.png"),
                               "door7": load("res://screens/play/locations/doors/door7.png"),
                               "door8": load("res://screens/play/locations/doors/door8.png")}
#var furniture_central       = {"desk_sm": load("res://screens/play/map/decor/furniture/desk_sm.png"),
#                               "heater": load("res://screens/play/map/decor/furniture/heater.png"),
#                               "shelf1": load("res://screens/play/map/decor/furniture/shelf1.png"),
#                               "shelf2": load("res://screens/play/map/decor/furniture/shelf2.png")}
#  
#var furniture_corner        = {"bed_table": load("res://screens/play/map/decor/furniture/bed_table.png"),
#                               "sink": load("res://screens/play/map/decor/furniture/sink.png"),
#                               "chair1": load("res://screens/play/map/decor/furniture/chair1.png"),
#                               "chair2": load("res://screens/play/map/decor/furniture/chair2.png"),
#                               "cupboard": load("res://screens/play/map/decor/furniture/cupboard.png"),
#                               "shelf3": load("res://screens/play/map/decor/furniture/shelf3.png")}

func _ready():
#	load_grid()
	load_walls()
	pass
	
func load_walls():
	pass
	
func load_grid():
	for i in range(17):
		grid.append([])
		for j in range(10):
			grid[i].append(null)
			for room in get_node("map").get_children():
#				room.initialize_door_types()
				if room.coordinates.x == i && room.coordinates.y == j:
					room._init()
					grid[i][j] = room
					room.initialize_door_types()