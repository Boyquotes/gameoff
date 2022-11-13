extends Node

class_name SpawnerManager

@export var spawn_offset = Vector2(0, -100)
@export var animation_time = 0.3

func _init() -> void:
    Globals.spawner = self

func spawn(position: Vector2, item: SpawnableItem):
    GlobalEvents.emit_signal("spawn_requested", position, item)

    var obj = item.template.instantiate()
    obj.global_position = position
    Globals.objects_root.add_child(obj)
    var tweener = get_tree().create_tween()
    tweener.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
    tweener.tween_property(obj, "global_position", position, animation_time).from(position + spawn_offset).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
    tweener.parallel()
    tweener.tween_property(obj, "scale", Vector2(0.8, 1), animation_time).from(Vector2(0.6, 1.3))
    tweener.tween_property(obj, "scale", Vector2(1.5, 0.5), animation_time/3).set_ease(Tween.EASE_OUT)
    tweener.tween_property(obj, "scale", Vector2(1, 1), animation_time/3).set_ease(Tween.EASE_IN)

    await tweener.finished
    GlobalEvents.emit_signal("spawn_completed", position, item)
    print("spawn completed")
    return obj
