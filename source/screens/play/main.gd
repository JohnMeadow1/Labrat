extends Node2D

var mouse_click_pos   = Vector2()


func _input(ev):
	
	if ev.type==InputEvent.MOUSE_BUTTON && ev.button_index == BUTTON_LEFT && !ev.pressed :
		mouse_click_pos = ev.pos
		GLOBAL.is_clicked = true
	elif (ev.type==InputEvent.MOUSE_MOTION):
		GLOBAL.mouse_pos = ev.pos
		GLOBAL.is_clicked = false
	else:
		GLOBAL.is_clicked = false
#	print (GLOBAL.is_clicked)

func _fixed_process(delta):
	if GLOBAL.mouse_pos.x > 800:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow1").set_opacity( 0.5 )
	else:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow1").set_opacity( 0 )
	if GLOBAL.mouse_pos.x < 200:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow").set_opacity( 0.5 )
	else:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow").set_opacity( 0 )
	if GLOBAL.mouse_pos.y < 100:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow2").set_opacity( 0.5 )
	else:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow2").set_opacity( 0 )
	if GLOBAL.is_clicked:
#		get_node("mouse_clicked").set_pos(mouse_click_pos)
#		print ("Clicked at: ",mouse_click_pos)
		if mouse_click_pos.x>800:
			GLOBAL.map_orientation -= 1
		if mouse_click_pos.x<200:
			GLOBAL.map_orientation += 1
		if GLOBAL.map_orientation<0:
			GLOBAL.map_orientation = 3
		GLOBAL.map_orientation %= 4
		
		if mouse_click_pos.y < 100:
			print (GLOBAL.map_orientation)
			if GLOBAL.map_orientation == 1 || GLOBAL.map_orientation == 3:
				GLOBAL.map_pos += Vector2( 0, GLOBAL.map_orientation - 2 )
			else:
				GLOBAL.map_pos -= Vector2( GLOBAL.map_orientation-1, 0 )

#		print( GLOBAL.map_orientation )
	get_node("map/selector").set_pos( GLOBAL.map_pos * 80 + Vector2(40,40) )
	get_node("map/selector").set_rot( GLOBAL.map_orientation*(PI/2) )

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	