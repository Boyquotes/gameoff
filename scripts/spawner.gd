extends Path2D

@export var spawn_template: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_timer_timeout():
	spawn()

func spawn():
	var item = spawn_template.instantiate()
	$PathFollow2D.progress_ratio = randf()
	item.global_position = $PathFollow2D.position
	owner.add_child(item)
	if item.has_method("change_target_destination"):
		item.change_target_destination(Globals.player.global_position)
