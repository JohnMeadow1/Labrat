extends "res://screens/play/items/abstract_item.gd"

var result = null

func set_variables():
	mini_scale    = 0.25
	current_scale = 0.25
	pass

func _ready():
	pick_result()
	pass

	
func enable():
	target_scale = 1
	result.set_hidden(false)
	
func dissable():
	target_scale = 0.25
	result.set_hidden(true)

func pick_result():
	result = get_node("Area2D/result" + str(GLOBAL.player_id))