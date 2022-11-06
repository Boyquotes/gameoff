extends Character

class_name FakePlayer

signal path_changed

@export var speed: float

var _moving_towards_target = false

var _enemies_in_range: Dictionary = {}
var _current_target: Node2D

func _process(delta: float) -> void:
	_refresh_target()

func set_level_exit(target):
	print(target)
	$"%MoveTowardsLevelEnd".destination = target.get_path()

func _physics_process(delta):
	# pathfinding movement
	queue_redraw()
	if _moving_towards_target:
		_navigate_towards_target(delta)

func change_target_destination(new_target: Vector2):
	get_node("NavigationAgent2D").set_target_location(new_target)
	get_node("NavigationAgent2D").get_next_location()
	emit_signal("path_changed")
	_moving_towards_target = true

func stop_movement():
	_moving_towards_target = false

func _navigate_towards_target(delta):
	if $NavigationAgent2D.is_target_reached():
		return
	var next = $NavigationAgent2D.get_next_location()
	var towards_next = next - global_position
	_move_towards(towards_next, delta)
	
func _move_towards(direction: Vector2, delta: float):
	if direction.length() > 1:
		direction = direction.normalized()
	direction *= speed * delta
	
	if direction.length() > 0:
		velocity = direction
		move_and_slide()
		$Sprite.flip_h = direction.x < 0
		$Sprite.play("walk")
	else: 
		$Sprite.play("idle")

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

func shoot():
	if _current_target:
		$MachineGunWeapon.shoot(_current_target)

func _refresh_target():
	# TODO choose closest
	if not _current_target and len(_enemies_in_range) > 0:
		_current_target = _enemies_in_range.values()[0]

func _on_visibility_area_body_entered(body: Node2D) -> void:
	if not _is_targetable(body):
		return
	_acquire_target(body)
	body.emit_signal("player_entered_target_area", self)
	_enemies_in_range[body.get_instance_id()] = body

func _on_visibility_area_body_exited(body: Node2D) -> void:
	if not _is_targetable(body):
		return
	_remove_target(body)
	body.emit_signal("player_exited_target_area")
	_enemies_in_range.erase(body.get_instance_id())

func _is_targetable(body: Node2D):
	return body is Enemy or body is Barrel

func _acquire_target(enemy: Character):
	print("Acquired target %s" % enemy)
	_current_target = enemy

func _remove_target(enemy: Character):
	print("Lost target %s" % enemy)
	_current_target = null
