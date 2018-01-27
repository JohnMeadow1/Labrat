extends "res://screens/play/items/abstract_door.gd"

func process_item():
	if GLOBAL.is_clicked && mouse_inside:
		get_tree().get_root().get_node("main").move_in_room()
	
func unlock():
		get_node("Area2D").set_hidden(false)
