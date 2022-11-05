extends Area2D

@export var damage: int = 0

func init(origin: Vector2, damage: int) -> void:
	$Sprite.flip_h = global_position.x - origin.x < 0
	$Sprite.animation = "spray%d" % randi_range(1, 5)
	damage = damage

func _on_sprite_animation_finished() -> void:
	queue_free()

func _on_body_entered(body:Node2D) -> void:
	# print("hit %s" % body)
	body.emit_signal("received_damage", damage)
