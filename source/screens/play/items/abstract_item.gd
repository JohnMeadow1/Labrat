extends Node2D

var mini_scale    = 1
var current_scale = 1
var target_scale  = 1.0
var mouse_inside  = false
var animate       = false
var is_enabled    = false


func _ready():
	set_fixed_process(true)
	set_variables()
	get_node("Area2D").set_scale( Vector2(mini_scale,mini_scale) )
	get_node("Area2D").connect("mouse_enter",self, 'mouse_enter')
	get_node("Area2D").connect("mouse_exit",self, 'mouse_exit')

func _fixed_process(delta):
	if GLOBAL.is_clicked && mouse_inside:
		animate            = true
		target_scale       = 1
		is_enabled         = true
		GLOBAL.item_active = true
		enable()
	elif GLOBAL.is_clicked && mouse_inside == false:
		animate            = true
		target_scale       = 0.25
		is_enabled         = false
		GLOBAL.item_active = false
		dissable()
		
	if animate:
		current_scale = lerp(current_scale, target_scale, 0.1)
		if abs(target_scale - current_scale) < 0.02:
			current_scale = target_scale
			animate       = false
		get_node("Area2D").set_scale(Vector2(current_scale,current_scale))
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
