extends "res://screens/play/items/abstract_item.gd"



func set_variables():
	pass

func process_item():
	pass
	
func enable():
	target_scale = 1
	get_node("Area2D/Screen").set_hidden(false)
	
func dissable():
	target_scale = 0.25
	get_node("Area2D/Screen").set_hidden(true)