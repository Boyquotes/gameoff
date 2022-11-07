extends Character

class_name Barrel

@export var explosion_template: PackedScene

func _die():
	emit_signal("has_died")
	var explosion = explosion_template.instantiate()
	explosion.global_position = global_position
	get_parent().call_deferred("add_child", explosion)
	queue_free()
	