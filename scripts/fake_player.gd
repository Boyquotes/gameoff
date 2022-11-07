extends Character

class_name FakePlayer

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


func _is_targetable(body: Node2D):
	return body is Enemy or body is Barrel


func _on_visibility_area_body_entered(body: Node2D) -> void:
	if not _is_targetable(body):
		return
	_acquire_target(body)
	if body.has_signal("player_entered_target_area"):
		body.emit_signal("player_entered_target_area", self)
	_enemies_in_range[body.get_instance_id()] = body

func _on_visibility_area_body_exited(body: Node2D) -> void:
	if not _is_targetable(body):
		return
	_remove_target(body)
	if body.has_signal("player_exited_target_area"):
		body.emit_signal("player_exited_target_area", self)
	_enemies_in_range.erase(body.get_instance_id())