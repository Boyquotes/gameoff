extends CharacterBody2D

class_name Actor

signal received_damage(damage: int, receiver: Node2D, origin: Node2D)
signal health_updated(current_health: int, previous_health: int, max_health: int)
signal just_died(actor: Actor)

@export var health_start: int = 100

var dynamic_fields = {}

@onready var _health_current = health_start


func _on_received_damage(damage: int, _receiver: Node2D, origin: Node2D) -> void:
	add_health(-damage)

func add_health(health: int):
	_health_current += health
	_health_current = min(_health_current, health_start)

	emit_signal("health_updated", _health_current, _health_current - health, health_start)
	if _health_current <= 0:
		_die()

func _die():
	emit_signal("just_died", self)
	queue_free()

func get_health():
	return _health_current