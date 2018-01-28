extends Node2D

var mouse_click_pos   = Vector2()
#var animate_rotation  = false
var animate_through_door  = false
var timer       = 1
var decor = 0

var dead        = {"dead0": load("res://images/game_over1.png"),
                   "dead1": load("res://images/game_over2.png"),
                   "dead2": load("res://images/game_over3.png"),
                   "dead3": load("res://images/game_over4.png")}
var is_alive     = true
var mouse_inside = false
func _input(ev):
	if is_alive:
		if ev.is_action_released("click"):
			GLOBAL.is_clicked = true
		else:
			GLOBAL.is_clicked = false
		if (ev.type == InputEvent.MOUSE_MOTION):
			GLOBAL.mouse_pos = ev.pos

func die():
	GLOBAL.audio.play("krzyk"+str(randi()%3 +1))
	is_alive = false
	get_node("game_over").set_texture(dead['dead'+str(randi()%4) ])
	
func _fixed_process(delta):
	if GLOBAL.item_active == false:
		process_movement()
	set_compass()
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
	elif mouse_inside:
		if GLOBAL.is_clicked:
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow2").set_opacity( 0 )
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow1").set_opacity( 0 )
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow").set_opacity( 0 )
			move_in_room()
	else:
		get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow2").set_opacity( 0 )
		if GLOBAL.mouse_pos.x > 1500:
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow1").set_opacity( 0.5 )
			if GLOBAL.is_clicked:
				turn(-1)
		else:
			get_node("gui_overlay/Control/Container/HBoxContainer/turn_arrow1").set_opacity( 0 )
		if GLOBAL.mouse_pos.x < 300:
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
	GLOBAL.compass_target_orientation += value
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
	
func set_compass():
	GLOBAL.compass_orientation = lerp (GLOBAL.compass_orientation, GLOBAL.compass_target_orientation, 0.1)
	get_node("gui_overlay/arrow").set_rot(GLOBAL.compass_orientation*PI/2)
	
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
	
func show_decor():
	var room = GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y]
#	print(room.decor)
	
	for d in room.decor.values(): d.set_hidden(true)
	
	var side = 1
	
	if GLOBAL.map_orientation == 0: side = 1
	elif GLOBAL.map_orientation == 1: side = 4
	elif GLOBAL.map_orientation == 2: side = 8
	elif GLOBAL.map_orientation == 3: side = 2
	
#	print(side)
	
	if side == 4:
		room.decor[side].set_hidden(false)

#func reload_room():
#	if GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y] != null:
#		unload_room()
#		load_room(GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y])
		
func load_room(room):
	print(GLOBAL.map_pos ," ", room.coordinates)
	print(" code", room.password)
	load_wall(room, get_node("room/walls/wall_left")      , 1)
	load_wall(room, get_node("room/walls/wall_right")     , 2)
	load_wall(room, get_node("room/walls/wall_top")       , 4)
	load_wall(room, get_node("room/walls/wall_bottom")    , 8)

	load_door(room,get_node("room/walls/wall_left/Door")  , 1)
	load_door(room,get_node("room/walls/wall_right/Door") , 2)
	load_door(room,get_node("room/walls/wall_top/Door")   , 4)
	load_door(room,get_node("room/walls/wall_bottom/Door"), 8)
	
#	load_furniture(room,get_node("room/walls/wall_left/Door"), 1)
	
	set_trap(room)
	
	clear_decor(get_node("room/walls/wall_left/Decor"))
	clear_decor(get_node("room/walls/wall_right/Decor"))
	clear_decor(get_node("room/walls/wall_top/Decor"))
	clear_decor(get_node("room/walls/wall_bottom/Decor"))
	
	if room.get_trap_type() == 0:
		load_decor(room, 1)
		load_decor(room, 2)
		load_decor(room, 4)
		load_decor(room, 8)

<<<<<<< HEAD
=======
func load_decor(room, side):
	if !room.decor.has(side): init_decor(room, side)
	
	if room.decor.has(side) && room.decor[side] != null:
		room.decor[side].set_hidden(false)

func init_decor(room, side):
	var wall_node = null
	
	if side == 1: wall_node = get_node("room/walls/wall_left/Decor")
	if side == 2: wall_node = get_node("room/walls/wall_right/Decor")
	if side == 4: wall_node = get_node("room/walls/wall_top/Decor")
	if side == 8: wall_node = get_node("room/walls/wall_bottom/Decor")
	
	if room.get_room_type() == 0 && room.get_sector() == 0: #Isolation Cell
		if room.get_doors(side):
			room.decor[side] = wall_node.get_node("HoldingCell/Door")
		else:
			room.decor[side] = wall_node.get_node("HoldingCell").get_child(decor % 3)
			decor += 1
	elif room.get_room_type() == 1: #Corridor
		if room.get_wall(side):
			wall_node = wall_node.get_node("DecorWall")
			var offset = decor % (wall_node.get_child_count ( ) + 10)
			if offset < wall_node.get_child_count():
				room.decor[side] = wall_node.get_child(offset)
			elif decor % 3 == 0:
				room.decor[side] = wall_node.get_node("../Sector").get_child((decor % 2) + 2 * (room.get_sector() -1 ))
			else:
				room.decor[side] = null
			decor += 13
	elif room.get_room_type() == 4: #Warehouse
		if room.get_wall(side):
			wall_node = wall_node.get_node("Warehouse")
			if decor % 3 == 0:
				room.decor[side] = wall_node.get_child(0)
			else:
				room.decor[side] = wall_node.get_child(1)
		else:
			room.decor[side] = null
		decor += 1
	elif room.get_room_type() == 5: #Lab
		if room.get_wall(side):
			wall_node = wall_node.get_node("Lab")
			room.decor[side] = wall_node.get_child(decor % 2)
		else:
			room.decor[side] = null
		decor += 1
	elif room.get_room_type() == 6: #Animal
		if room.get_wall(side):
			wall_node = wall_node.get_node("Animal")
			room.decor[side] = wall_node.get_child(decor % 4)
		else:
			room.decor[side] = null
		decor += 1
	elif room.get_room_type() == 7: #Study
		if room.get_wall(side):
			wall_node = wall_node.get_node("Study")
			if decor % 4 == 0:
				room.decor[side] = wall_node.get_child(0)
			elif decor % 4 == 1:
				room.decor[side] = wall_node.get_child(1)
			else:
				room.decor[side] = wall_node.get_child(2)
		else:
			room.decor[side] = null
		decor += 1

func clear_decor(decor_node):
	for nodes in decor_node.get_children():
		for decor in nodes.get_children():
			decor.set_hidden(true);

>>>>>>> 204f4bd47bd7d8e8125112043b1878851047d4f1
func load_wall(room, node, side):
#	print(room.get_name(), node.get_name(), side)
	if room.get_wall(side):
		node.set_texture(GLOBAL.map.walls['wall'])
		node.get_node("Area2D").set_hidden(true)
	else:
		node.set_texture(GLOBAL.map.walls['deep_wall'])
		node.get_node("Area2D").set_hidden(false)
		
func load_door(room, node, side):
	print("room: ",room,' ',room.coordinates, " lock_type ", room.get_lock_type(side))
	if room.get_doors(side):
#		print(room.doors_style.values())
		node.get_node("door").set_texture(room.doors_style[side])
		node.door_side = side
		node.set_hidden(false)
		var lock_node = null 
#		print(room.get_lock_type(side))
		if room.get_lock_type(side) == 1:
			node.get_node("HandLock").set_hidden(false)
			node.get_node("Keypad").set_hidden(true)
			node.get_node("Cardlock").set_hidden(true)
			lock_node = node.get_node("HandLock")
		elif room.get_lock_type(side) == 2:
			node.get_node("HandLock").set_hidden(true)
			node.get_node("Keypad").set_hidden(true)
			node.get_node("Cardlock").set_hidden(false)
			lock_node = node.get_node("Cardlock")
		elif room.get_lock_type(side) == 0:
			node.get_node("HandLock").set_hidden(true)
			node.get_node("Keypad").set_hidden(false)
			node.get_node("Keypad").valid_code = room.password
			node.get_node("Cardlock").set_hidden(true)
			lock_node = node.get_node("Keypad")
		else:
			node.get_node("HandLock").set_hidden(true)
			node.get_node("Keypad").set_hidden(true)
			node.get_node("Cardlock").set_hidden(true)
			
		print("locked door: ",room.get_locked_doors(side) )
		if room.get_locked_doors(side): 
#			print(room.get_lock_type(side))
			if room.get_door_state(side):
				node.unlock(lock_node)
				node.get_node("lamp").set_modulate(Color(0.5,1,0.5))
			else:
				node.lock(lock_node)
				node.get_node("lamp").set_modulate(Color(1,0.5,0.5))
		else:
			node.get_node("lamp").set_modulate(Color(0.5,1,0.5))
			node.get_node("Keypad").set_hidden(true)
			node.get_node("HandLock").set_hidden(true)
			node.get_node("Cardlock").set_hidden(true)
			if lock_node:
				lock_node.set_hidden(false)
				lock_node.get_node("Area2D").set_hidden(true)
			node.get_node("Area2D").set_hidden(false)
	else:
		node.set_hidden(true)

func load_decor(room, side):
	if !room.decor.has(side): init_decor(room, side)
	
	if room.decor.has(side) && room.decor[side] != null:
		room.decor[side].set_hidden(false)

func init_decor(room, side):
	var wall_node = null
	
	if side == 1: wall_node = get_node("room/walls/wall_left/Decor")
	if side == 2: wall_node = get_node("room/walls/wall_right/Decor")
	if side == 4: wall_node = get_node("room/walls/wall_top/Decor")
	if side == 8: wall_node = get_node("room/walls/wall_bottom/Decor")
	
	if room.get_room_type() == 0:
		if room.get_doors(side):
			room.decor[side] = wall_node.get_node("HoldingCell/Door")
		else:
			room.decor[side] = wall_node.get_node("HoldingCell").get_child(decor % 3)
			decor += 1
	elif room.get_room_type() == 1:
		if room.get_wall(side):
			wall_node = wall_node.get_node("DecorWall")
			var offset = decor % (wall_node.get_child_count ( ) + 10)
			if offset < wall_node.get_child_count():
				room.decor[side] = wall_node.get_child(offset)
			elif decor % 3 == 0:
				room.decor[side] = wall_node.get_node("../Sector").get_child((decor % 2) + 2 * (room.get_sector() -1 ))
			else:
				room.decor[side] = null
			decor += 13
		else:
			room.decor[side] = null

func clear_decor(decor_node):
	for nodes in decor_node.get_children():
		for decor in nodes.get_children():
			decor.set_hidden(true);

func _ready():
	GLOBAL.map.load_grid()
	set_fixed_process(true)
	set_process_input(true)
	pick_start()
	get_orientation_vector()
#	print (GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y])
	load_room( GLOBAL.map.grid[GLOBAL.map_pos.x][GLOBAL.map_pos.y] )
	get_node("room/walls/wall_left/Area2D").connect("mouse_enter",self, 'mouse_enter')
	get_node("room/walls/wall_left/Area2D").connect("mouse_exit",self, 'mouse_exit')
	get_node("room/walls/wall_right/Area2D").connect("mouse_enter",self, 'mouse_enter')
	get_node("room/walls/wall_right/Area2D").connect("mouse_exit",self, 'mouse_exit')
	get_node("room/walls/wall_top/Area2D").connect("mouse_enter",self, 'mouse_enter')
	get_node("room/walls/wall_top/Area2D").connect("mouse_exit",self, 'mouse_exit')
	get_node("room/walls/wall_bottom/Area2D").connect("mouse_enter",self, 'mouse_enter')
	get_node("room/walls/wall_bottom/Area2D").connect("mouse_exit",self, 'mouse_exit')
	GLOBAL.audio = get_node("SamplePlayer")
	get_node("ambient").play("laboratorium1")
	
func mouse_enter():
	mouse_inside = true
func mouse_exit():
	mouse_inside = false
	
func pick_start():
	var list = []
	for room in GLOBAL.map.get_node("map").get_children():
		if room.get_sector() == 0:
			list.append(room)
	var room = list[randi() % list.size()]
#	GLOBAL.map_pos = Vector2(0,8)
	GLOBAL.map_pos = room.coordinates
	GLOBAL.map_orientation = randi() % 4
	get_node("room/walls").set_pos(Vector2(1,0) * 1920 * GLOBAL.map_orientation + Vector2(960,540))

func set_trap(room):
	if room.get_trap_type() > 0:
		get_node("room/Trap").set_hidden(false)
		if room.get_trap_type() == 1:
			get_node("room/Trap/Sprite").set_texture(load("res://screens/play/map/decor/liquid.png"))
			get_node("room/Trap/Sprite").set_modulate(Color(0.2,0.7,0.2))
		elif room.get_trap_type() == 2:
			get_node("room/Trap/Sprite").set_texture(load("res://screens/play/map/decor/monsterl.png"))
			get_node("room/Trap/Sprite").set_modulate(Color(0.7,0.2,0.5))
	else:
		get_node("room/Trap").set_hidden(true)
		
func check_trap():
	if get_node("room/Trap").is_visible():
		
		die()