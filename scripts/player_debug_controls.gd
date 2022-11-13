extends Node2D

func _physics_process(delta):
	# input movement
	var input_velocity = Input.get_vector("debug_move_left", "debug_move_right", "debug_move_up", "debug_move_down")
	if input_velocity.length_squared() != 0:
		owner._move_towards(input_velocity, delta)

func _unhandled_input(event: InputEvent):
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed):
		return
		
	owner.change_target_destination(get_global_mouse_position())