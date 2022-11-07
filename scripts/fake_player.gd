extends Character

class_name FakePlayer

signal ammo_updated(current_ammo: int, previous_ammo: int, max_ammo: int)

@export var ammo_start: int = 100

@onready var _ammo_current = ammo_start

func add_ammo(value: int):
	_ammo_current += value
	_ammo_current = min(_ammo_current, ammo_start)
	_ammo_current = max(_ammo_current, 0)
	emit_signal("ammo_updated", _ammo_current, _ammo_current - value, ammo_start)

func get_ammo():
	return _ammo_current

func set_level_exit(target):
	$"%MoveTowardsLevelEnd".destination = target.get_path()

func _process(delta: float) -> void:
	_refresh_target()

func _physics_process(delta):
	# pathfinding movement
	queue_redraw()
	if _moving_towards_target:
		_navigate_towards_target(delta)

func _draw():
	# draw full path
	var points = $NavigationAgent2D.get_nav_path()
	if len(points) == 0:
		return
	var s = to_local(points[0])
	for i in range(1, len(points)):
		draw_line(s, to_local(points[i]), Color.RED)
		s = to_local(points[i])
		
	# draw movement to next point
	var next = to_local($NavigationAgent2D.get_next_location())
	draw_line(Vector2.ZERO, next, Color.MAGENTA, 3)


func _map_type(type_name: String):
	if type_name == "player":
		return null
	if type_name == "enemy":
		return "enemy"
	if type_name == "barrel":
		return "enemy"
	return type_name
