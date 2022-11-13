extends CharacterBody2D

class_name Actor

signal received_damage(damage: int, receiver: Node2D, origin: Node2D)
signal health_updated(current_health: int, previous_health: int, max_health: int)
signal just_died(actor: Actor)

@export var health_start: int = 100
@export var particles_template: PackedScene

var dynamic_fields = {}

@onready var _health_current = health_start


func _on_received_damage(damage: int, _receiver: Node2D, origin: Node2D) -> void:
	add_health(-damage)
	var dir = global_position - origin.global_position
	spawn_particles(dir)

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

func spawn_particles(direction: Vector2):
	if particles_template == null:
		return
	var particles = particles_template.instantiate()
	particles.position = Vector2.ZERO
	particles.rotation = direction.angle()
	particles.emitting = true
	self.add_child(particles)
