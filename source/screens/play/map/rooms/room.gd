tool
extends Node2D

var color_array        = [Color(.39,.68,.21),Color(1,1,.32),Color(.98,.6,.07),Color(1,.15,.07),Color(.51,0,.65),Color(.07,.27,.98)]
export(int, "Cell_block", "Lab_A", "Lab_B", "Lab_C", "Animal testing", "Decontamination") var sector = 0 setget set_sector, get_sector
export(int, FLAGS, "Left", "Right", "Top", "Bottom") var walls setget set_walls, get_walls
export(int, FLAGS, "Left", "Right", "Top", "Bottom") var doors setget set_doors, get_doors
export(int, FLAGS, "Left", "Right", "Top", "Bottom") var locked_doors setget set_locked_doors, get_locked_doors

export(int, "Isolation", "Corridor", "Decontamination", "Trap") var room_type  setget set_room_type, get_room_type

var doors_state = 0



#var wall_textures = []
var furnitures = []

onready var coordinates = Vector2()
func _init():
	coordinates = (get_pos()-Vector2(41.0,41.0))/80.0
func _ready():
	coordinates = (get_pos()-Vector2(41.0,41.0))/80.0
#	if room_type == 0:
#		furnitures.append(randi()%GLOBAL.map.furniture.size())
#	print(coordinates)
#	coordinates = (get_pos()-Vector2(41,41))/80
#	get_node("Label").set_text(str(coordinates))
	pass
func set_room_type(new_value):
	if new_value !=null:
		room_type = new_value
		
func get_room_type():
	return room_type
	
func set_sector(new_value):
	if new_value !=null:
		sector = new_value
		get_node("room_bg").set_modulate(color_array[new_value])

func get_sector():
	return sector
	
func set_locked_doors( new_value ):
	if new_value !=null:
		locked_doors = new_value
		if new_value & 1 == 1: get_node("room_bg/door_left_locked").set_hidden(false)
		else:                  get_node("room_bg/door_left_locked").set_hidden(true)
		if new_value & 2 == 2: get_node("room_bg/door_right_locked").set_hidden(false)
		else:                  get_node("room_bg/door_right_locked").set_hidden(true)
		if new_value & 4 == 4: get_node("room_bg/door_top_locked").set_hidden(false)
		else:                  get_node("room_bg/door_top_locked").set_hidden(true)
		if new_value & 8 == 8: get_node("room_bg/door_bottom_locked").set_hidden(false)
		else:                  get_node("room_bg/door_bottom_locked").set_hidden(true)

func get_locked_doors( side ):
	if locked_doors & side == side: return true
	return false

func set_walls( new_value ):
	if new_value !=null:
		walls = new_value
		if new_value & 1 == 1: get_node("room_bg/wall_left").set_hidden(false)
		else:                  get_node("room_bg/wall_left").set_hidden(true)
		if new_value & 2 == 2: get_node("room_bg/wall_right").set_hidden(false)
		else:                  get_node("room_bg/wall_right").set_hidden(true)
		if new_value & 4 == 4: get_node("room_bg/wall_top").set_hidden(false)
		else:                  get_node("room_bg/wall_top").set_hidden(true)
		if new_value & 8 == 8: get_node("room_bg/wall_bottom").set_hidden(false)
		else:                  get_node("room_bg/wall_bottom").set_hidden(true)

func get_wall( side ):
	if walls & side == side: return true
	return false
	
func get_walls():
	return walls
	
func set_doors( new_value ):
	if new_value != null:
		doors = new_value
		if new_value & 1 == 1: 
			get_node("room_bg/door_left").set_hidden(false)
		else:                  get_node("room_bg/door_left").set_hidden(true)
		if new_value & 2 == 2: get_node("room_bg/door_right").set_hidden(false)
		else:                  get_node("room_bg/door_right").set_hidden(true)
		if new_value & 4 == 4: get_node("room_bg/door_top").set_hidden(false)
		else:                  get_node("room_bg/door_top").set_hidden(true)
		if new_value & 8 == 8: get_node("room_bg/door_bottom").set_hidden(false)
		else:                  get_node("room_bg/door_bottom").set_hidden(true)
	
func get_doors( side ):
	if doors && (doors & side) == side: return true
	return false

func unlock_door(side):
	doors_state += side
	
func get_door_state(side):
	if (doors_state & side) == side: return true
