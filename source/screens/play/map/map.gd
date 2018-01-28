tool
extends Node2D

var grid                    = []
var walls                   = {"wall": load("res://screens/play/locations/wall.png"),
                               "deep_wall": load("res://screens/play/locations/corridor.png")}
func _ready():
	pass
	
func load_grid():
	for room in get_node("map").get_children():
		room._init()
		room.initialize_door_types()
		room.set_passwords()
		
	for i in range(18):
		grid.append([])
		for j in range(10):
			grid[i].append(null)
			for room in get_node("map").get_children():
				if room.coordinates.x == i && room.coordinates.y == j:
					grid[i][j] = room