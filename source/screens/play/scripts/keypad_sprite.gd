extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)
	pass


func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
        if event.pos > self.get_pos() && event.pos < self.get_pos() + get_size():
             print ("1")
	pass