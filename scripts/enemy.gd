extends Character

class_name Enemy

signal player_entered_target_area
signal player_exited_target_area


func _ready() -> void:
	change_target_destination(global_position)

func _process(delta: float) -> void:
	_refresh_target()

func _physics_process(delta):
	# pathfinding movement
	queue_redraw()
	if _moving_towards_target:
		_navigate_towards_target(delta)

func _on_player_entered_target_area(player: Node2D) -> void:
	_acquire_target(player)
	_enemies_in_range[player.get_instance_id()] = player

func _on_player_exited_target_area(player: Node2D) -> void:
	_remove_target(player)
	_enemies_in_range.erase(player.get_instance_id())


func _on_visibility_area_body_entered(body: Node2D) -> void:
	if not body is Enemy:
		return
	_friendlies_in_range[body.get_instance_id()] = body
	body.connect("received_damage", _on_friendly_received_damage)

func _on_visibility_area_body_exited(body: Node2D) -> void:
	if not body is Enemy:
		return
	_friendlies_in_range.erase(body.get_instance_id())
	body.disconnect("received_damage", _on_friendly_received_damage)

func _on_friendly_received_damage(damage: int, receiver: Node2D, origin: Node2D):
	# if has_reached_target():
	change_target_destination(origin.global_position)
	resume_movement()
