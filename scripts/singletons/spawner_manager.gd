extends Node

class_name SpawnerManager

func _init() -> void:
    Globals.spawner = self

func spawn(position: Vector2, item: SpawnableItem):
    GlobalEvents.emit_signal("spawn_requested", position, item)
    var obj = item.template.instantiate()
    obj.global_position = position
    Globals.objects_root.add_child(obj)
    return obj
