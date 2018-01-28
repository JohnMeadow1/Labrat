extends TextureButton

var normal = Color(1, 1, 1)
var hover = Color(0.75, 0.75, 0.75)
var pressed = Color(0.5, 0.5, 0.5)

export (String) var name
var selected = false

var original_position = get_pos()
var move_to = Vector2(0,0)

var pickuped = false
var animate = false
var value = 0;

func _ready():
	set_fixed_process(true)
	original_position = get_pos()
#	self.set_scale(self.get_scale() / get_node("/root/global").viewport_scale)
	self.connect("mouse_enter",self,"_on_mouse_enter")
	self.connect("mouse_exit",self,"_on_mouse_exit")
	self.connect("button_down",self,"_on_button_down")
	self.connect("button_up",self,"_on_button_up")
	set_process_input(true)
	
func _on_mouse_exit():
	if !selected:
		set_modulate(normal)

func _on_mouse_enter():
	if !selected:
		set_modulate(hover)

func _on_button_down():
#	print (GLOBAL.selected_item_index)
	if GLOBAL.selected_item_index > -1:
		GLOBAL.picked_items[GLOBAL.selected_item_index].selected = false
		GLOBAL.picked_items[GLOBAL.selected_item_index].set_modulate(normal)
	var item_index = GLOBAL.picked_items.find(self)
	if item_index == -1:
		pick_item()
	selected = true
	GLOBAL.selected_item_index = GLOBAL.picked_items.find(self)
	set_modulate(pressed)

func _on_button_up():
	if !selected:
		set_modulate(hover)

func _fixed_process(delta):
	if(animate):
		var start = get_pos()
		var pos = start.linear_interpolate(move_to, value)
		value += delta
		set_pos(pos)
		if pos == move_to:
			animate = false
			set_hidden(true)
			get_tree().get_root().get_node("main/gui_overlay/hand").set_hidden(false)
			value = 0

func pick_item():
	GLOBAL.picked_items.append(self)
	move_item(self)

func use_item():
	self.queue_free();
	get_tree().get_root().get_node("main/gui_overlay/hand").set_hidden(true)
#	GLOBAL.picked_items.remove(GLOBAL.selected_item_index);
	GLOBAL.picked_items.erase(self)
	GLOBAL.selected_item_index = -1
	if GLOBAL.picked_items.size() > 0:
		for item in GLOBAL.picked_items:
			move_item(item)
			
func move_item(item):
	var item_index = GLOBAL.picked_items.find(item)
	item.move_to = Vector2(-900, -375) + Vector2(0, 150) * item_index
	item.animate = true;