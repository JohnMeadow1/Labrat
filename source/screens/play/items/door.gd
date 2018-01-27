extends "res://screens/play/items/abstract_item.gd"

func set_variables():
	mini_scale    = 1
	current_scale = 1
	pass

func process_item():
	pass
	
func enable():
	target_scale = 1
	if(get_node("Keypad").get("is_open")):
		get_tree().get_root().get_node("main").move_in_room()
	
func dissable():
	target_scale = 1