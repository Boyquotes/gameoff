extends Area2D

func _ready() -> void:
	$Sprite.animation = "spray%d" % randi_range(1, 5)

func _on_sprite_animation_finished() -> void:
	queue_free()

func _on_body_entered(body:Node2D) -> void:
	print("hit %s" % body)
