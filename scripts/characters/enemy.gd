extends Character

class_name Enemy

@export var xp_value: int = 1

func _ready() -> void:
	change_target_destination(global_position)
	connect("just_died", Globals.player._on_enemy_killed)

func _on_visibility_area_body_entered(body: Node2D) -> void:
	super._on_visibility_area_body_entered(body)
	var type = _map_type(_node_to_type(body))
	if type == "friendly":
		body.connect("received_damage", _on_friendly_received_damage)

func _on_visibility_area_body_exited(body: Node2D) -> void:
	super._on_visibility_area_body_exited(body)
	if body.has_signal("received_damage") and body.is_connected("received_damage", _on_friendly_received_damage):
		body.disconnect("received_damage", _on_friendly_received_damage)

func _on_friendly_received_damage(damage: int, receiver: Node2D, origin: Node2D):
	change_target_destination(origin.global_position)

func _map_type(type_name):
	if type_name == "player":
		return "enemy"
	if type_name == "enemy":
		return "friendly"
	return null

func get_xp_value() -> int:
	return xp_value

func _on_just_died(actor) -> void:
	GlobalEvents.emit_signal("enemy_died", self)
