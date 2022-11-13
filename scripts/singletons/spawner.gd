extends Path2D

@export var item_index: int
@export var spawnable_items: SpawnableItems

func _on_timer_timeout():
	spawn()

func spawn():
	$PathFollow2D.progress_ratio = randf()
	var item = await Globals.spawner.spawn($PathFollow2D.position, spawnable_items.items[item_index])
	if item.has_method("change_target_destination"):
		item.change_target_destination(Globals.player.global_position)
