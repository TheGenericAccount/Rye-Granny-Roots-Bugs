extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
const NO_ITMS=8
var start_pos
var last_id=-1
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		if !visible:
			visible=true
			set_global_position(get_global_mouse_position())
			start_pos=get_global_mouse_position()
		if start_pos and start_pos.distance_to(get_global_mouse_position())<20:
			return
		var angle=(-(start_pos-get_global_mouse_position()).angle_to(Vector2.UP) + PI)
		var itm_index=0
		while (itm_index+1)*(2*PI)/NO_ITMS<angle:
			itm_index+=1

		itm_index=min(itm_index, NO_ITMS-1)
		if(last_id>=0):
			get_child(last_id).get_node("Anim").play("deselect")
		last_id=itm_index
		#if NO_ITMS>itm_index:
		get_child(itm_index).select_itm ()
	elif visible:
		visible=false
		chg_itm()

func chg_itm():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
