tool
extends Node2D

var grid                    = []
var walls                   = {"wall": load("res://screens/play/locations/wall.png"),
                               "deep_wall": load("res://screens/play/locations/wall_deep.png")}

var furniture_central       = {"desk_sm": load("res://screens/play/map/decor/furniture/desk_sm.png"),
                               "heater": load("res://screens/play/map/decor/furniture/heater.png"),
                               "shelf1": load("res://screens/play/map/decor/furniture/shelf1.png"),
                               "shelf2": load("res://screens/play/map/decor/furniture/shelf2.png")}
  
var furniture_corner        = {"bed_table": load("res://screens/play/map/decor/furniture/bed_table.png"),
                               "sink": load("res://screens/play/map/decor/furniture/sink.png"),
                               "chair1": load("res://screens/play/map/decor/furniture/chair1.png"),
                               "chair2": load("res://screens/play/map/decor/furniture/chair2.png"),
                               "cupboard": load("res://screens/play/map/decor/furniture/cupboard.png"),
                               "shelf3": load("res://screens/play/map/decor/furniture/shelf3.png")}

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
				room._init()
				if room.coordinates.x == i && room.coordinates.y == j:
					grid[i][j] = room