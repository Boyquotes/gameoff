extends Node2D

signal path_changed


func _physics_process(delta):
	# input movement
	var input_velocity = Input.get_vector("player_move_left", "player_move_right", "player_move_up", "player_move_down")
	get_node("..").move_towards(input_velocity, delta)

func _unhandled_input(event: InputEvent):
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed):
		return
		
	get_node("../NavigationAgent2D").set_target_location(get_global_mouse_position())
	get_node("../NavigationAgent2D").get_next_location()
	emit_signal("path_changed")