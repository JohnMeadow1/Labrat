extends "res://screens/play/items/abstract_item.gd"

export (String) var valid_code
var is_open = false

func set_variables():
	mini_scale    = 0.25
	current_scale = 0.25
	pass

func process_item():
	pass
	
func enable():
	if(!is_open):
		target_scale = 1
		get_node("Area2D/Screen").set_hidden(false)
	
func dissable():
	target_scale = 0.25
	get_node("Area2D/Screen").set_hidden(true)

func validateCode(code):
	if (code == valid_code):
		is_open = true
		get_node("Light").set_modulate(Color(0,255,0))
		dissable()
		animate = true;
	pass