extends Sprite

var velocity        = Vector2()
var position        = Vector2()
var scale           = 1.0
var scale_direction = 1.0

var color_array        = [Color(.39,.68,.21),Color(1,1,.32),Color(.98,.6,.07),Color(1,.15,.07),Color(.51,0,.65),Color(.07,.27,.98)]


func _ready():
	randomize()
	scale           = rand_range( 0.5, 1.5 )
	scale_direction = 1 - ( 2 * (randi() % 2) )
	position        = Vector2( rand_range( 1, GLOBAL.screen_res.x ), rand_range( 1, GLOBAL.screen_res.y ) )
	velocity        = Vector2( rand_range( -2, 2 ), rand_range( -2, 2 ) )
	set_pos( position )
	set_modulate( color_array[randi()%color_array.size()] )
	set_fixed_process( true )

func _fixed_process( delta ):
	position = get_pos() + velocity

	if   position.x < -100:
		 position.x = GLOBAL.screen_res.x + 100
	elif position.x > GLOBAL.screen_res.x + 100:
		 position.x = -100

	if   position.y < -100:
		 position.y = GLOBAL.screen_res.y + 100
	elif position.y > GLOBAL.screen_res.y + 100:
		 position.y = -100
	set_pos(position)


	scale += scale_direction * 0.005
	if (scale < 0 ):
		scale = 0
		scale_direction = 1
		position = Vector2( rand_range( 1, GLOBAL.screen_res.x ), rand_range( 1, GLOBAL.screen_res.y ) )
		set_pos(position)
	if (scale > 2):
		scale_direction *=-1
	set_scale(Vector2(scale,scale))

