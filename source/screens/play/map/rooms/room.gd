tool
extends Node2D

var color_array        = [Color(.39,.68,.21),Color(1,1,.32),Color(.98,.6,.07),Color(1,.15,.07),Color(.51,0,.65),Color(.07,.27,.98)]
export(int, "Cell_block", "Lab_A", "Lab_B", "Lab_C", "Animal testing", "Decontamination") var sector setget set_sector, get_sector
export(int, FLAGS, "Left", "Right", "Top", "Bottom") var walls setget set_walls, get_walls
export(int, FLAGS, "Left", "Right", "Top", "Bottom") var doors setget set_doors, get_doors
export(int, FLAGS, "Left", "Right", "Top", "Bottom") var locked_doors setget set_locked_doors, get_locked_doors
export(int, FLAGS, "Left", "Right", "Top", "Bottom") var danger_doors setget set_danger_doors, get_danger_doors

export(int, "Isolation", "Corridor", "Decontamination", "Archive", "Warehouse", "Lab", "Animal testing", "Study room" ) var room_type setget set_room_type, get_room_type
export(int, "None", "Acid", "Monster") var trap_type setget set_trap_type, get_trap_type

export(int, "None", "Finger", "Card") var unique_pad_left   setget set_unique_lock_left ,get_lock_type
export(int, "None", "Finger", "Card") var unique_pad_right  setget set_unique_lock_right ,get_lock_type
export(int, "None", "Finger", "Card") var unique_pad_top    setget set_unique_lock_top   ,get_lock_type
export(int, "None", "Finger", "Card") var unique_pad_bottom setget set_unique_lock_bottom,get_lock_type

var doors_style = {}
var doors_state = 0
var password   = ""

var decor       = {}

onready var coordinates = Vector2()
func _init():
	coordinates = (get_pos()-Vector2(41.0,41.0))/80.0
	if room_type == 0:
		if sector == 1:
			password = GLOBAL.passwords["Isolation_S1"+str(randi()%3)]
		elif sector == 2:
			password = GLOBAL.passwords["Isolation_S2"+str(randi()%3)]
		elif sector == 3:
			password = GLOBAL.passwords["Isolation_S3"+str(randi()%3)]
		elif sector == 4:
			password = GLOBAL.passwords["Isolation_S4"+str(randi()%3)]
	elif room_type == 1:
		password = GLOBAL.passwords["Decontamination_"+str(randi()%3)]
	elif room_type == 2:
		password = GLOBAL.passwords["Archive_"+str(randi()%3)]
	elif room_type == 3:
		password = GLOBAL.passwords["Warehouse_"+str(randi()%3)]
	elif room_type == 4:
		password = GLOBAL.passwords["Lab_"+str(randi()%3)]
	elif room_type == 5:
		password = GLOBAL.passwords["Animal_testing_"+str(randi()%3)]
	elif room_type == 6:
		password = GLOBAL.passwords["Study_room_"+str(randi()%3)]
func _ready():
	pass
#	coordinates = (get_pos()-Vector2(41.0,41.0))/80.0


func initialize_door_types():
	if sector == 0:
		doors_style[1] = GLOBAL.map.doors["door1"]
		doors_style[2] = GLOBAL.map.doors["door1"]
		doors_style[4] = GLOBAL.map.doors["door1"]
		doors_style[8] = GLOBAL.map.doors["door1"]
	elif sector == 1:
		doors_style[1] = GLOBAL.map.doors["door"+str(randi()%2+2)]
		doors_style[2] = GLOBAL.map.doors["door"+str(randi()%2+2)]
		doors_style[4] = GLOBAL.map.doors["door"+str(randi()%2+2)]
		doors_style[8] = GLOBAL.map.doors["door"+str(randi()%2+2)]
	elif sector == 2:
		doors_style[1] = GLOBAL.map.doors["door"+str(randi()%2+3)]
		doors_style[2] = GLOBAL.map.doors["door"+str(randi()%2+3)]
		doors_style[4] = GLOBAL.map.doors["door"+str(randi()%2+3)]
		doors_style[8] = GLOBAL.map.doors["door"+str(randi()%2+3)]
	elif sector == 3:
		doors_style[1] = GLOBAL.map.doors["door"+str(randi()%2+4)]
		doors_style[2] = GLOBAL.map.doors["door"+str(randi()%2+4)]
		doors_style[4] = GLOBAL.map.doors["door"+str(randi()%2+4)]
		doors_style[8] = GLOBAL.map.doors["door"+str(randi()%2+4)]
	elif sector == 4:
		doors_style[1] = GLOBAL.map.doors["door"+str(randi()%2+5)]
		doors_style[2] = GLOBAL.map.doors["door"+str(randi()%2+5)]
		doors_style[4] = GLOBAL.map.doors["door"+str(randi()%2+5)]
		doors_style[8] = GLOBAL.map.doors["door"+str(randi()%2+5)]
	elif sector == 5:
		doors_style[1] = GLOBAL.map.doors["door"+str(randi()%2+7)]
		doors_style[2] = GLOBAL.map.doors["door"+str(randi()%2+7)]
		doors_style[4] = GLOBAL.map.doors["door"+str(randi()%2+7)]
		doors_style[8] = GLOBAL.map.doors["door"+str(randi()%2+7)]
	
#	print(doors_style)
	
func set_room_type(new_value):
	if new_value !=null:
		room_type = new_value
		
func get_room_type():
	return room_type

func set_trap_type(new_value):
	if new_value !=null:
		trap_type = new_value
		
func get_trap_type():
	return trap_type

func set_sector(new_value):
	if new_value !=null:
		sector = new_value
		get_node("room_bg").set_modulate(color_array[new_value])

func get_sector():
	return sector
func set_unique_lock_left(new_value):
	if new_value != null:
		unique_pad_left = new_value
		
func set_unique_lock_right(new_value):
	if new_value != null:
		unique_pad_right = new_value
		
func set_unique_lock_top(new_value):
	if new_value != null:
		unique_pad_top = new_value
		
func set_unique_lock_bottom(new_value):
	if new_value != null:
		unique_pad_bottom = new_value
	
func get_lock_type(side):

	if side == 1:
		return unique_pad_left
	if side == 2:
		return unique_pad_right
	if side == 4:
		return unique_pad_top
	if side == 8:
		return unique_pad_bottom

func set_locked_doors( new_value ):
	if new_value !=null:
		locked_doors = new_value
		if new_value & 1 == 1: get_node("room_bg/door_left_locked").set_hidden(false)
			doors_state += 1
		else:                  get_node("room_bg/door_left_locked").set_hidden(true)
		if new_value & 2 == 2: get_node("room_bg/door_right_locked").set_hidden(false)
			doors_state += 2
		else:                  get_node("room_bg/door_right_locked").set_hidden(true)
		if new_value & 4 == 4: get_node("room_bg/door_top_locked").set_hidden(false)
			doors_state += 4
		else:                  get_node("room_bg/door_top_locked").set_hidden(true)
		if new_value & 8 == 8: get_node("room_bg/door_bottom_locked").set_hidden(false)
			doors_state += 8
		else:                  get_node("room_bg/door_bottom_locked").set_hidden(true)

func get_locked_doors( side ):
	if locked_doors:
		if locked_doors & side == side: return true
	return false
	
func set_danger_doors( new_value ):
	if new_value !=null:
		danger_doors = new_value
		if new_value & 1 == 1: get_node("room_bg/door_left_danger").set_hidden(false)
		else:                  get_node("room_bg/door_left_danger").set_hidden(true)
		if new_value & 2 == 2: get_node("room_bg/door_right_danger").set_hidden(false)
		else:                  get_node("room_bg/door_right_danger").set_hidden(true)
		if new_value & 4 == 4: get_node("room_bg/door_top_danger").set_hidden(false)
		else:                  get_node("room_bg/door_top_danger").set_hidden(true)
		if new_value & 8 == 8: get_node("room_bg/door_bottom_danger").set_hidden(false)
		else:                  get_node("room_bg/door_bottom_danger").set_hidden(true)
	
func get_danger_doors( side ):
	if danger_doors & side == side: return true

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
		if new_value & 1 == 1: get_node("room_bg/door_left").set_hidden(false)
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
	if locked_doors:
		locked_doors -= side
	
func get_door_state(side):
	if (doors_state & side) == side: return true
