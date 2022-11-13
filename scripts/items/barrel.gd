extends Actor

class_name Barrel

@export var explosion_template: PackedScene

func _die():
	emit_signal("just_died")
	GlobalEvents.emit_signal("explosion_happened", self.global_position)
	var explosion = explosion_template.instantiate()
	explosion.global_position = global_position
	get_parent().call_deferred("add_child", explosion)
	queue_free()
	