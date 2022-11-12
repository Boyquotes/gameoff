extends RigidBody2D

signal items_ready(items: Array[Dictionary])
signal changed_item(PackedScene)

@export var speed: float
@export var zoom_speed_multiplier: float
@export var zoom_time: float = 0.1
@export var single_click_tolerance_msec: int = 100
@export var pan_camera_factor = 1.2
@export var item_templates: Array[Dictionary]
@export_flags_2d_physics var collision_layer_mask: int

var _currently_selected_idx = 0
var _time_click_start = null
var _click_start_position = null
var _camera_start_position = null

func _ready() -> void:
	emit_signal("items_ready", item_templates)

# TODO separate input logic

func _process(delta: float) -> void:
	if _time_click_start == null or $TouchHandler.is_zooming:
		return
	# maybe can use InputEventMouseMotion instead
	var camera_delta = (get_local_mouse_position() - _click_start_position) * pan_camera_factor
	global_position = _camera_start_position - camera_delta

func _physics_process(delta):
	# input movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.length() > 1:
		direction = direction.normalized()
	direction *= speed * delta * _get_zoom_level()
	
	if direction.length() > 0:
		apply_force(direction)
		# old code for kinematic body
		# velocity = direction
		# move_and_slide()

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		_handle_left_mouse(event)
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				_zoom_camera(1 + zoom_speed_multiplier)
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				_zoom_camera(1 - zoom_speed_multiplier)
	
	elif event is InputEventKey and event.pressed and not event.echo:
		if event.keycode >= KEY_1 and event.keycode <= KEY_9:
			_currently_selected_idx = event.keycode - KEY_1
			_currently_selected_idx %= len(item_templates)
			select_item(_currently_selected_idx)

func _is_short_click():
	if _time_click_start == null or single_click_tolerance_msec == null:
		return true
	else:
		return Time.get_ticks_msec() - _time_click_start < single_click_tolerance_msec

func _handle_left_mouse(event: InputEventMouseButton):
	if event.button_index != MOUSE_BUTTON_LEFT:
		return

	if event.pressed:
		_time_click_start = Time.get_ticks_msec()
		_click_start_position = get_local_mouse_position()
		_camera_start_position = global_position
	else:
		if _is_short_click():
			_try_place_item(get_global_mouse_position())
		_time_click_start = null
		_click_start_position = null
				

func select_item(idx: int):
	_currently_selected_idx = idx
	var item_name = str(_get_selected_item()["name"])
	print("Selected: %s" % item_name)
	emit_signal("changed_item", item_name)

func _try_place_item(pos: Vector2):
	var query = PhysicsRayQueryParameters2D.create(pos, pos + Vector2(1,0), collision_layer_mask)
	query.hit_from_inside = true
	var collision = get_world_2d().direct_space_state.intersect_ray(query) # TODO should do a shapecast with a circle for better precision

	if "position" in collision:
		print("not spawning item because colliding")
		return
		
	_place_item(pos)

func _get_selected_item() -> Dictionary:
	return item_templates[_currently_selected_idx]

func _place_item(spawn_pos: Vector2):
	var obj = _get_selected_item()["template"].instantiate()
	obj.global_position = spawn_pos
	$"%ObjectsRoot".add_child(obj)

func _zoom_camera(zoom_mult):
	var target_zoom = $Camera2D.zoom * zoom_mult
	get_tree().create_tween().tween_property($Camera2D, "zoom", target_zoom, zoom_time)
	# $Camera2D.zoom *= zoom_mult


func set_zoom(zoom):
	var target_zoom = Vector2(zoom, zoom)
	get_tree().create_tween().tween_property($Camera2D, "zoom", target_zoom, zoom_time)

func _get_zoom_level():
	return 1/$Camera2D.zoom.x
