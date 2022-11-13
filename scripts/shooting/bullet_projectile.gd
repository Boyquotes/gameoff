extends Area2D

@export var damage: int = 0

var _owner: Node2D = self
var _destination = null
var _speed = 0.0

func init(origin: Vector2, damage: int, owner: Node2D, destination = null,
	speed: float = 0.0, color: Color = Color.WHITE
) -> void:
	damage = damage
	_owner = owner
	_destination = destination
	_speed = speed
	set_color(color)

func _physics_process(delta: float) -> void:
	if _destination == null:
		return
	var destination_direction = _destination - global_position
	if destination_direction.length() < _speed * delta:
		queue_free()
	var direction = destination_direction.normalized()
	position += direction * _speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_signal("received_damage"):
		body.emit_signal("received_damage", damage, body, _owner)
	queue_free()

func set_color(color: Color):
	$Sprite.modulate = color
