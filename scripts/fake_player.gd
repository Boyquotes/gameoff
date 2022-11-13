extends Character

class_name FakePlayer

func _ready() -> void:
	change_target_destination(global_position)

func set_level_exit(target):
	$"%MoveTowardsLevelEnd".destination = target.get_path()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	update_path_renderer()
	# queue_redraw()

func update_path_renderer(): # TODO move line to parent so no need to redraw on every frame
	var points = $NavigationAgent2D.get_nav_path()
	if len(points) == 0:
		return
	var line_points = PackedVector2Array()
	for point in points:
		line_points.append(to_local(point))
	$Line2D.points = line_points

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


func _map_type(type_name):
	if type_name == "player":
		return null
	if type_name == "enemy":
		return "enemy"
	if type_name == "barrel":
		return "enemy"
	return type_name

func _remember_type(type: String) -> bool:
	return type == "ammo" or type == "health"