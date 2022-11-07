extends Character

class_name Enemy

func _ready() -> void:
	change_target_destination(global_position)

func _process(delta: float) -> void:
	_refresh_target()

func _physics_process(delta):
	# pathfinding movement
	queue_redraw()
	if _moving_towards_target:
		_navigate_towards_target(delta)

func _on_visibility_area_body_entered(body: Node2D) -> void:
	super._on_visibility_area_body_entered(body)
	body.connect("received_damage", _on_friendly_received_damage)

func _on_visibility_area_body_exited(body: Node2D) -> void:
	super._on_visibility_area_body_exited(body)
	body.disconnect("received_damage", _on_friendly_received_damage)

func _on_friendly_received_damage(damage: int, receiver: Node2D, origin: Node2D):
	change_target_destination(origin.global_position)
	resume_movement()

func _map_type(type_name: String):
	if type_name == "player":
		return "enemy"
	if type_name == "enemy":
		return "friendly"
	return null
