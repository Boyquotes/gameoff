extends CharacterBody2D

class_name Character

signal received_damage(damage: int)
signal has_died

@export var health_start: int = 100

@onready var _health_current = health_start


func _on_received_damage(damage: int) -> void:
	_health_current -= damage
	if _health_current <= 0:
		_die()

func _die():
	emit_signal("has_died")
	print("%s killed" % self)
	queue_free()