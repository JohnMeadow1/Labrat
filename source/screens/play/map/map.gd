extends Node2D

var grid                    = []

func _ready():
#	load_grid()
	pass

func load_grid():
	for i in range(10):
		grid.append([])
		for j in range(10):
			grid[i].append(null)
			for room in get_node("map").get_children():
				room._init()
				if room.coordinates.x == i && room.coordinates.y == j:
					grid[i][j] = room