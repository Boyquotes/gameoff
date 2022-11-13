extends Node

@export var shoot_interval_msec: float
@export var shoot_randomness: float
@export var bullet_template: PackedScene
@export var damage: int

signal shot_fired

# var _last_shot_time = 0
var _shoot_timer = null

func shoot(target: Node):
	if _shoot_timer != null:
		if _shoot_timer.time_left > 0:
			return
		# else:
		# 	_shoot_timer = null
	if get_parent().get_ammo() <= 0:
		return

	_shoot_timer = get_tree().create_timer(shoot_interval_msec / 1000.0)
	var bullet = bullet_template.instantiate()
	var random_dir = Vector2(
		randf_range(-shoot_randomness, shoot_randomness),
		randf_range(-shoot_randomness, shoot_randomness)
	) # TODO not uniform

	bullet.global_position = target.global_position + random_dir
	get_node("../../..").add_child(bullet) # TODO rethink node structure
	bullet.init(get_parent().global_position, damage, get_parent())

	get_parent().add_ammo(-1)

	emit_signal("shot_fired")
