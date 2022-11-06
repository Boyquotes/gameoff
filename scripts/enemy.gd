extends Character

class_name Enemy

signal player_entered_target_area
signal player_exited_target_area


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
