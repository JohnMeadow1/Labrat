extends Node2D

var mouse_click_pos   = Vector2()
#var animate_rotation  = false
var animate_through_door  = false
var timer = 1

func _input(ev):
	if ev.type == InputEvent.MOUSE_BUTTON && ev.button_index == BUTTON_LEFT && !ev.is_pressed() :
		mouse_click_pos = ev.pos
		GLOBAL.is_clicked = true
	elif (ev.type == InputEvent.MOUSE_MOTION):
		GLOBAL.mouse_pos = ev.pos
		GLOBAL.is_clicked = false
	else:
		GLOBAL.is_clicked = false

func _fixed_process(delta):
	if GLOBAL.item_active == false:
		process_movement()
	get_node("room/walls").set_pos(get_node("room/walls").get_pos().linear_interpolate( Vector2(1,0) * 1920 * GLOBAL.map_orientation + Vector2(960,540),0.1 ))
	
	if animate_through_door:
		timer -= delta * 2
		if GLOBAL.map_orientation == 0:
			get_node("room/walls/wall_left").set_scale(   Vector2(1+(1-timer)/2,1+(1-timer)/2) )
		elif GLOBAL.map_orientation == 1:
			get_node("room/walls/wall_top").set_scale(    Vector2(1+(1-timer)/2,1+(1-timer)/2) )
		elif GLOBAL.map_orientation == 2:
			get_node("room/walls/wall_right").set_scale(  Vector2(1+(1-timer)/2,1+(1-timer)/2) )
		elif GLOBAL.map_orientation == 3:
			get_node("room/walls/wall_bottom").set_scale( Vector2(1+(1-timer)/2,1+(1-timer)/2) )
		if timer <=0 :
			timer = 1
			animate_through_door = false
			get_node("room/walls/wall_left").set_scale(   Vector2(1,1) )
			get_node("room/walls/wall_top").set_scale(    Vector2(1,1) )
			get_node("room/walls/wall_right").set_scale(  Vector2(1,1) )
			get_node("room/walls/wall_bottom").set_scale( Vector2(1,1) )
			enter_the_room()
			
		
func process_movement():
	if GLOBAL.mouse_pos.y < 100:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow2").set_opacity( 0.5 )
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow1").set_opacity( 0 )
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow").set_opacity( 0 )
		if GLOBAL.is_clicked:
			move_in_room()
	else:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow2").set_opacity( 0 )
		if GLOBAL.mouse_pos.x > 1600:
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow1").set_opacity( 0.5 )
			if GLOBAL.is_clicked:
				turn(-1)
		else:
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow1").set_opacity( 0 )
		if GLOBAL.mouse_pos.x < 200:
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow").set_opacity( 0.5 )
			if GLOBAL.is_clicked:
				turn(1)
		else:
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow").set_opacity( 0 )

	get_node("minimap/map/selector").set_pos( GLOBAL.map_pos * 80 + Vector2(40,40) )
	get_node("minimap/map/selector").set_rot( GLOBAL.map_orientation * ( PI/2 ) )
	
func turn( value ):
	GLOBAL.map_orientation += value

#	print(GLOBAL.map_orientation, " ", get_node("room/walls").get_pos() )
	if GLOBAL.map_orientation < 0:
		GLOBAL.map_orientation = 3
		get_node("room/walls/wall_right").set_pos(Vector2(-7680,0) )
		get_node("room/walls/wall_bottom").set_pos(Vector2(-5760,0) )
		get_node("room/walls").set_pos( Vector2(7680+960,540) )
	elif GLOBAL.map_orientation > 3:
		GLOBAL.map_orientation = 0
		get_node("room/walls/wall_bottom").set_pos(Vector2(1920,0 ) )
		get_node("room/walls/wall_right").set_pos(Vector2(0,0) )
		get_node("room/walls").set_pos( Vector2(-1920+960,540) )
	else:
		get_node("room/walls/wall_right").set_pos(Vector2(0,0) )
		get_node("room/walls/wall_bottom").set_pos(Vector2(-5760,0) )
		
	get_orientation_vector()

func get_orientation_vector():
	if GLOBAL.map_orientation == 0:
		GLOBAL.map_orientation_vect = Vector2(1,0)
	if GLOBAL.map_orientation == 1:
		GLOBAL.map_orientation_vect = Vector2(0,-1)
	if GLOBAL.map_orientation == 2:
		GLOBAL.map_orientation_vect = Vector2(-1,0)
	if GLOBAL.map_orientation == 3:
		GLOBAL.map_orientation_vect = Vector2(0,1)
#	print(GLOBAL.map_orientation_vect )
	
func move_in_room():
	animate_through_door = true
func enter_the_room():
	if GLOBAL.map_orientation == 1 || GLOBAL.map_orientation == 3:
		if GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y +  GLOBAL.map_orientation - 2 ] != null:
			animate_through_door = true
			GLOBAL.map_pos += GLOBAL.map_orientation_vect
			load_room(GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y])
	else:
		if GLOBAL.map.grid[GLOBAL.map_pos.x - (GLOBAL.map_orientation - 1)][ GLOBAL.map_pos.y ] != null:
			animate_through_door = true
			GLOBAL.map_pos += GLOBAL.map_orientation_vect
			load_room( GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y] )
	
#func reload_room():
#	if GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y] != null:
#		unload_room()
#		load_room(GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y])
		
func load_room(room):
#	print(GLOBAL.map_pos)
	load_wall(room, get_node("room/walls/wall_left"), 1)
	load_wall(room, get_node("room/walls/wall_right"), 2)
	load_wall(room, get_node("room/walls/wall_top"), 4)
	load_wall(room, get_node("room/walls/wall_bottom"), 8)

	load_door(room,get_node("room/walls/wall_left/Door")  , 1)
	load_door(room,get_node("room/walls/wall_right/Door") , 2)
	load_door(room,get_node("room/walls/wall_top/Door")   , 4)
	load_door(room,get_node("room/walls/wall_bottom/Door"), 8)

func load_wall(room, node, side):
	if room.get_wall(side):
		node.set_texture(GLOBAL.map.walls['wall'])
	else:
		node.set_texture(GLOBAL.map.walls['deep_wall'])
		
func load_door(room, node, side):
	if room.get_doors(side):
#		print("doors")
		node.door_side = side
		if room.get_door_state(side):
#			print("unlocked")
			node.unlock()
		else:
#			print("locked")
			node.lock()
		node.set_hidden(false)
	else:
		node.set_hidden(true)

func _ready():
	GLOBAL.map.load_grid()
	set_fixed_process(true)
	set_process_input(true)
	load_room( GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y] )
	get_orientation_vector()
