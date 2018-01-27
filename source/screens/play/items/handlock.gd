extends "res://screens/play/items/abstract_item.gd"

var valid_code = "1"
var is_open = false

func set_variables():
#	valid_code = get_parent().get("valid_code")
	mini_scale    = 0.25
	current_scale = 0.25
	pass

func process_item():
	if is_open:
		if animate == false:
			get_parent().unlock(self)
			set_fixed_process(false)
		else:
			animate            = true
			target_scale       = 0.25
			is_enabled         = false
			GLOBAL.item_active = false
	
func enable():
	if(!is_open):
		target_scale = 1
#		get_node("Area2D/Screen").set_hidden(false)
		get_node("Area2D/buttons").set_hidden(false)
	
func dissable():
	target_scale = 0.25
	get_node("Area2D/buttons").set_hidden(true)

func validateCode(code):
	if (code == valid_code):
		GLOBAL.picked_items[GLOBAL.selected_item_index].use_item()
		is_open            = true
		animate            = true
		target_scale       = 0.25
		is_enabled         = false
		GLOBAL.item_active = false
		get_node("Area2D/buttons").set_hidden(true)
	pass
func lock():
	pass