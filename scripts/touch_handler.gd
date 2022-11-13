extends Node2D

@export var zoom_sensitivity: float

var _active_touches: Dictionary # InputEventScreenTouch or InputEventScreenDrag
var _touch_start: Dictionary # Vector2
var is_zooming = false
var _zoom_level_start = null

func _process(_delta: float) -> void:
	if len(_active_touches) != 2:
		is_zooming = false
		return
	if not is_zooming:
		_zoom_level_start = $"../Camera2D".zoom.x
		is_zooming = true
	var a = _active_touches.keys()[0]
	var b = _active_touches.keys()[1]
	var delta_a = _touch_start[a] - _active_touches[a].position
	var delta_b = _touch_start[b] - _active_touches[b].position
	var current_distance = (_active_touches[a].position - _active_touches[b].position).length()
	var start_distance = (_touch_start[a] - _touch_start[b]).length()

	var delta_zoom: float = (delta_a.length() + delta_b.length()) / zoom_sensitivity
	
	if current_distance > start_distance:
		# zoom in
		owner.set_zoom(_zoom_level_start + delta_zoom)
	else:
		# zoom out
		owner.set_zoom(_zoom_level_start * pow(2, -delta_zoom))
	
func _unhandled_input(event: InputEvent):
	#InputEventScreenTouch: index=12418, pressed=false, position=((144.2133, 374.7244))
	#InputEventScreenDrag: index=12483, position=((837.9733, 300.4623)), relative=((0, -0.426793)), velocity=((7.464558, -11.200155))
	if event is InputEventScreenTouch:
		if event.pressed:
			_active_touches[event.index] = event
			_touch_start[event.index] = event.position
		else:
			_active_touches.erase(event.index)
			_touch_start.erase(event.index)

	if event is InputEventScreenDrag:
		_active_touches[event.index] = event