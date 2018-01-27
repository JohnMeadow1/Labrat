extends TextureButton

export (Color) var normal
export (Color) var hover
export (Color) var pressed
export (String) var name

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
	set_modulate(normal)

func _on_mouse_enter():
	set_modulate(hover)

func _on_button_down():
	if GLOBAL.picked_item != self:
		if GLOBAL.picked_item != null:
			GLOBAL.picked_item.move_to = GLOBAL.picked_item.original_position
			GLOBAL.picked_item.animate = true
		move_to = Vector2(450, 630)	
		GLOBAL.picked_item = self
		GLOBAL.picked_item_name = name
		animate = true
	set_modulate(pressed)

func _on_button_up():
	set_modulate(hover)

func _fixed_process(delta):
	if(animate):
		var start = get_pos()
		var pos = start.linear_interpolate(move_to, value)
		value += delta
		set_pos(pos)
		if pos == move_to:
			animate = false
			value = 0