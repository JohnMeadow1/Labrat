extends Node2D
var grid                    = []
func _ready():
	
	for i in range(10):
		grid.append([])
		for j in range(10):
			grid[i].append(null)
			for room in get_node("map").get_children():
				if room.coordinates.x == i && room.coordinates.y == j:
					grid[i][j] = room