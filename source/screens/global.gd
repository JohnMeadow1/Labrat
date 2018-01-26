extends Node

const PLACEMENT_POINTS_PER_BALL = 10
const BALL_DISTANCE_FOR_COMBO   = 30 # pixels
const MIN_BALL_COUNT_FOR_COMBO  = 2
const BALL_OFFSET               = Vector2(0,-130)
const LEVELS_IN_MENU            = 3
var current_level               = 0

#var BASE_BALL_RADIUS            = 50
#const TOOL_FILL_RADIUS          = 160
#var   FILL_BALL_RADIUS          = 0.6 * BASE_BALL_RADIUS
#
#var BALL_COLOR_COUNT            = 3 
#var color_array                 = []

#var blocked_zone_color          = Color( 0.4, 0.4, 0.4 )

#var viewport_res   = Vector2()
var screen_res     = Vector2()
var update_res     = false

func _ready():
	screen_res   = OS.get_window_size()
#	viewport_res = get_node("/root").get_children()[1].get_viewport_rect().size
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (OS.get_window_size().x != screen_res.x):
		screen_res = OS.get_window_size()
		update_res = true