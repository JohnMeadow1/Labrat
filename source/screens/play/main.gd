extends Node2D

var mouse_click_pos   = Vector2()
#var animate_rotation  = false
var animate_through_door  = false
var timer       = 1

var dead        = {"dead0": load("res://images/game_over1.png"),
                   "dead1": load("res://images/game_over2.png"),
                   "dead2": load("res://images/game_over3.png"),
                   "dead3": load("res://images/game_over4.png")}
var is_alive    = true

func _input(ev):
	if is_alive:
		if ev.is_action_released("click"):
			GLOBAL.is_clicked = true
			
		else:
			GLOBAL.is_clicked = false
		if (ev.type == InputEvent.MOUSE_MOTION):
			GLOBAL.mouse_pos = ev.pos

func die():
	is_alive = false
	get_node("game_over").set_texture(dead['dead'+str(randi()%4) ])
	
func _fixed_process(delta):
	if GLOBAL.item_active == false:
		process_movement()
	get_node("room/walls").set_pos(get_node("room/walls").get_pos().linear_interpolate( Vector2(1,0) * 1920 * GLOBAL.map_orientation + Vector2(960,540),0.1 ))
	if !is_alive:
		timer -= delta/2
		get_node("game_over").set_modulate( Color(1,1,1,1-timer) )
		
	if animate_through_door:
		timer -= delta * 2
		get_node("Sprite").set_modulate( Color(1,1,1,1-timer) )
		if GLOBAL.map_orientation == 2:
			get_node("room/walls/wall_left").set_scale(   Vector2(1+(1-timer)/2,1+(1-timer)/2) )
		elif GLOBAL.map_orientation == 1:
			get_node("room/walls/wall_top").set_scale(    Vector2(1+(1-timer)/2,1+(1-timer)/2) )
		elif GLOBAL.map_orientation == 0:
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
			get_node("Sprite").set_modulate( Color(1,1,1,0) )
			
		
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
	GLOBAL.is_clicked = false
#	print(GLOBAL.map_orientation, " ", value)
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
#	print("move into")

	GLOBAL.is_clicked = false
	animate_through_door = true
	
func enter_the_room():
#	print("move into")
	if GLOBAL.map_orientation == 1 || GLOBAL.map_orientation == 3:
		if GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y +  GLOBAL.map_orientation - 2 ] != null:
			GLOBAL.map_pos += GLOBAL.map_orientation_vect
			load_room(GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y])
	else:
		if GLOBAL.map.grid[GLOBAL.map_pos.x - (GLOBAL.map_orientation - 1)][ GLOBAL.map_pos.y ] != null:
			GLOBAL.map_pos += GLOBAL.map_orientation_vect
			load_room( GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y] )
	
	check_trap()
	
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
	
	load_furniture(room,get_node("room/walls/wall_left/Door"), 1)
	
	set_trap(room)
	
func load_furniture(room, node, side):
	
	pass
func load_wall(room, node, side):
	if room.get_wall(side):
		node.set_texture(GLOBAL.map.walls['wall'])
	else:
		node.set_texture(GLOBAL.map.walls['deep_wall'])
		
func load_door(room, node, side):
	if room.get_doors(side):
		node.door_side = side
		node.set_hidden(false)
		if room.get_locked_doors(side): 
			if room.get_door_state(side):
				node.unlock()
			else:
				node.lock()
		else:
			node.get_node("Keypad").set_hidden(true)
			node.get_node("HandLock").set_hidden(true)
			node.get_node("Area2D").set_hidden(false)
	else:
		node.set_hidden(true)

func _ready():
	GLOBAL.map.load_grid()
	set_fixed_process(true)
	set_process_input(true)
	pick_start()
	load_room( GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y] )
	get_orientation_vector()
	
func pick_start():
	var list = []
	for room in GLOBAL.map.get_node("map").get_children():
		if room.get_room_type() == 0:
			list.append(room)
	var room = list[randi() % list.size()]
	GLOBAL.map_pos = Vector2(0,4)
#	GLOBAL.map_pos = room.coordinates
#	GLOBAL.map_orientation = randi() % 4
	get_node("room/walls").set_pos(Vector2(1,0) * 1920 * GLOBAL.map_orientation + Vector2(960,540))

func set_trap(room):
	if room.get_trap_type() > 0:
		get_node("room/Trap").set_hidden(false)
		if room.get_trap_type() == 1:
			get_node("room/Trap/Sprite").set_texture(load("res://screens/play/map/decor/small/liquid.png"))
			get_node("room/Trap/Sprite").set_modulate(Color(0.2,0.7,0.2))
		elif room.get_trap_type() == 2:
			get_node("room/Trap/Sprite").set_texture(load("res://screens/play/map/decor/small/stain.png"))
			get_node("room/Trap/Sprite").set_modulate(Color(0.7,0.2,0.5))
	else:
		get_node("room/Trap").set_hidden(true)
		
func check_trap():
	if get_node("room/Trap").is_visible():
		die()