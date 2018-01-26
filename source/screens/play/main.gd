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
#		get_node("mouse_clicked").set_pos(mouse_click_pos)
		print ("Clicked at: ",mouse_click_pos)
		if mouse_click_pos.x>500:
			GLOBAL.map_orientation -= 1
		if mouse_click_pos.x<100:
			GLOBAL.map_orientation += 1
		if mouse_click_pos.y>500:
			GLOBAL.map_pos -= Vector2( cos(GLOBAL.map_orientation*(PI/2)),-sin(GLOBAL.map_orientation*(PI/2)))
		if mouse_click_pos.y<100:
			GLOBAL.map_pos += Vector2( cos(GLOBAL.map_orientation*(PI/2)),-sin(GLOBAL.map_orientation*(PI/2)))
		GLOBAL.map_orientation %= 4
#		print( GLOBAL.map_orientation )
	get_node("map/selector").set_pos( GLOBAL.map_pos * 80 +Vector2(40,40) )
	get_node("map/selector").set_rot( GLOBAL.map_orientation*(PI/2) )

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	