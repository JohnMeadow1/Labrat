extends TextureButton

export (Color) var normal
export (Color) var hover
export (Color) var pressed
export (String) var value

func _ready():
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
	addValue()
	set_modulate(pressed)

func _on_button_up():
	set_modulate(hover)

func addValue():
	var text = get_parent().get_text()
	if text.length() < 3:
		get_parent().set_text(text + value)
	elif text.length() == 3:
		validateCode(text + value)
		get_parent().set_text("")

func validateCode(code):
	pass