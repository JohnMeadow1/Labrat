extends Node2D

var mouse_inside  = false

func _ready():
	set_fixed_process(true)
	get_node("Area2D").connect("mouse_enter",self, 'mouse_enter')
	get_node("Area2D").connect("mouse_exit",self, 'mouse_exit')

func _fixed_process(delta):
	process_item()
	
func process_item():
	pass
	
func set_variables():
	pass

func enable():
	pass

func dissable():
	pass

func mouse_enter():
	mouse_inside = true
	
func mouse_exit():
	mouse_inside = false
