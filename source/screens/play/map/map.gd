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

func _ready():
	pass
	
func load_grid():
	for room in get_node("map").get_children():
		room._init()
		room.initialize_door_types()
		
	for i in range(17):
		grid.append([])
		for j in range(10):
			grid[i].append(null)
			for room in get_node("map").get_children():
				if room.coordinates.x == i && room.coordinates.y == j:
					grid[i][j] = room