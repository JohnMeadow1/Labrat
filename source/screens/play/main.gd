extends Node2D

var mouse_click_pos   = Vector2()
var mouse_click_state = false


func _input(ev):
	mouse_click_state = false
	if ev.type==InputEvent.MOUSE_BUTTON && !ev.pressed:
		mouse_click_pos = ev.pos
		mouse_click_state = true
	elif (ev.type==InputEvent.MOUSE_MOTION):
#		mouse_click_state = true
		pass

#	print("Viewport Resolution is: ",get_viewport_rect().size)
	
func _fixed_process(delta):
	if mouse_click_state:
		get_node("mouse_clicked").set_pos(mouse_click_pos)
		print ("Clicked at: ",mouse_click_pos)

func _ready():
	set_fixed_process(true)
	set_process_input(true)