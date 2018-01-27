tool
extends Node2D

export(int, FLAGS, "Left", "Right", "Top", "Bottom") var walls = 0 setget set_walls, get_walls
export(int, FLAGS, "Left", "Right", "Top", "Bottom") var doors = 0 setget set_doors, get_doors

var coordinates = Vector2()


func _ready():
	coordinates = (get_pos()-Vector2(41,41))/80
#	get_node("Label").set_text(str(coordinates))
	pass
	

func set_walls( new_value ):
	walls = new_value
	if new_value & 1 == 1: get_node("room_bg/wall_left").set_hidden(false)
	else:                  get_node("room_bg/wall_left").set_hidden(true)
	if new_value & 2 == 2: get_node("room_bg/wall_right").set_hidden(false)
	else:                  get_node("room_bg/wall_right").set_hidden(true)
	if new_value & 4 == 4: get_node("room_bg/wall_top").set_hidden(false)
	else:                  get_node("room_bg/wall_top").set_hidden(true)
	if new_value & 8 == 8: get_node("room_bg/wall_bottom").set_hidden(false)
	else:                  get_node("room_bg/wall_bottom").set_hidden(true)
		
func get_walls():
	return walls
	
func set_doors( new_value ):
	doors = new_value
	if new_value & 1 == 1: get_node("room_bg/door_left").set_hidden(false)
	else:                  get_node("room_bg/door_left").set_hidden(true)
	if new_value & 2 == 2: get_node("room_bg/door_right").set_hidden(false)
	else:                  get_node("room_bg/door_right").set_hidden(true)
	if new_value & 4 == 4: get_node("room_bg/door_top").set_hidden(false)
	else:                  get_node("room_bg/door_top").set_hidden(true)
	if new_value & 8 == 8: get_node("room_bg/door_bottom").set_hidden(false)
	else:                  get_node("room_bg/door_bottom").set_hidden(true)
func get_doors():
	return doors