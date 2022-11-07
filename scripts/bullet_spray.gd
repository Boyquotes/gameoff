extends Area2D

@export var damage: int = 0

var _owner: Node2D = self

func init(origin: Vector2, damage: int, owner: Node2D) -> void:
	$Sprite.flip_h = global_position.x - origin.x < 0
	$Sprite.animation = "spray%d" % randi_range(1, 5)
	damage = damage
	_owner = owner

func _on_sprite_animation_finished() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	body.emit_signal("received_damage", damage, body, _owner)
