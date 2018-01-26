extends Node2D

var mini_scale    = 0.25
var current_scale = 0.25
var target_scale  = 1.0
var mouse_inside  = false
var animate       = false

func _ready():
	set_fixed_process(true)
	get_node("Area2D").set_scale( Vector2(mini_scale,mini_scale) )
	get_node("Area2D").connect("mouse_enter",self, 'mouse_enter')
	get_node("Area2D").connect("mouse_exit",self, 'mouse_exit')

func _fixed_process(delta):
	if GLOBAL.is_clicked && mouse_inside:
		animate = true
		target_scale = 1
	elif GLOBAL.is_clicked && mouse_inside == false:
		animate = true
		target_scale = 0.25
		
	if animate:
		current_scale = lerp(current_scale, target_scale, 0.1)
		if abs(target_scale - current_scale) < 0.02:
			current_scale = target_scale
			animate = false
		get_node("Area2D").set_scale(Vector2(current_scale,current_scale))


func mouse_enter():
	mouse_inside = true
	
func mouse_exit():
	mouse_inside = false
