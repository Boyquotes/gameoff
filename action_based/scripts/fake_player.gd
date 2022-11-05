extends CharacterBody2D

class_name FakePlayer

@export var speed: float

var _enemies_in_range: Dictionary = {}
var _target_enemy: Enemy

func _process(delta: float) -> void:
	_refresh_target()

	if _target_enemy:
		$MachineGunWeapon.shoot(_target_enemy)

func _physics_process(delta):
	# pathfinding movement
	queue_redraw()
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

func _on_path_changed() -> void:
	pass


# basic AI
func _refresh_target():
	# TODO choose closest
	if not _target_enemy and len(_enemies_in_range) > 0:
		_target_enemy = _enemies_in_range.values()[0]

func _on_visibility_area_body_entered(body: Node2D) -> void:
	if not body is Enemy:
		return
	_acquire_target(body)
	body.emit_signal("player_entered_target_area", self)
	_enemies_in_range[body.get_instance_id()] = body

func _on_visibility_area_body_exited(body:Node2D) -> void:
	if not body is Enemy:
		return
	_remove_target(body)
	body.emit_signal("player_exited_target_area")
	_enemies_in_range.erase(body.get_instance_id())

func _acquire_target(enemy: Enemy):
	print("Acquired target %s" % enemy)
	_target_enemy = enemy

func _remove_target(enemy: Enemy):
	print("Lost target %s" % enemy)
	_target_enemy = null
