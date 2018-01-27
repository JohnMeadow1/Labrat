extends "res://screens/play/items/abstract_door.gd"

export (String) var valid_code
var door_side = 0

func process_item():
	if GLOBAL.is_clicked && mouse_inside:
		get_tree().get_root().get_node("main").move_in_room()
	
func unlock():
#	print("unlock")
	get_node("Area2D").set_hidden( false )
	get_node("lamp").set_modulate( Color( 0.5, 1, 0.5 ) )
#	print("unlocking",  GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y].get_door_state(door_side))
	if !GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y].get_door_state(door_side):
		GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y].unlock_door(door_side)
#		print("unlocking " +str(door_side) + " at ", GLOBAL.map_pos)
		if door_side == 1 :
			GLOBAL.map.grid[GLOBAL.map_pos.x+GLOBAL.map_orientation_vect.x][GLOBAL.map_pos.y+GLOBAL.map_orientation_vect.y].unlock_door(2)
#			print("unl nbr left ", GLOBAL.map_pos+GLOBAL.map_orientation_vect)
		if door_side == 2 :
			GLOBAL.map.grid[GLOBAL.map_pos.x+GLOBAL.map_orientation_vect.x][GLOBAL.map_pos.y+GLOBAL.map_orientation_vect.y].unlock_door(1)
#			print("unl nbr right ", GLOBAL.map_pos+GLOBAL.map_orientation_vect)
		if door_side == 4 :
			GLOBAL.map.grid[GLOBAL.map_pos.x+GLOBAL.map_orientation_vect.x][GLOBAL.map_pos.y+GLOBAL.map_orientation_vect.y].unlock_door(8)
#			print("unl nbr bottom ", GLOBAL.map_pos+GLOBAL.map_orientation_vect)
		if door_side == 8 :
			GLOBAL.map.grid[GLOBAL.map_pos.x+GLOBAL.map_orientation_vect.x][GLOBAL.map_pos.y+GLOBAL.map_orientation_vect.y].unlock_door(4)
#			print("unl nbr top ", GLOBAL.map_pos+GLOBAL.map_orientation_vect)
		
func lock():
	get_node("Area2D").set_hidden( true )
	get_node("lamp").set_modulate( Color( 1, 1, 1 ) )
	get_node("Keypad/Area2D").set_hidden(false)
	get_node("Keypad").set_fixed_process(true)
	get_node("Keypad").is_open = false
	get_node("Keypad").lock()