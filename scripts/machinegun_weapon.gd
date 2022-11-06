extends Node

@export var shoot_interval_msec: float
@export var shoot_randomness: float
@export var bullet_template: PackedScene
@export var damage: int

signal shot_fired

var _last_shot_time = 0

func shoot(target: Node):
	if Time.get_ticks_msec() - _last_shot_time < shoot_interval_msec:
		return

	_last_shot_time = Time.get_ticks_msec()
	var bullet = bullet_template.instantiate()
	var random_dir = Vector2(
		randf_range(-shoot_randomness, shoot_randomness),
		randf_range(-shoot_randomness, shoot_randomness)
	) # TODO not uniform

	bullet.global_position = target.global_position + random_dir
	get_node("../..").add_child(bullet) # TODO rethink node structure
	bullet.init(get_parent().global_position, damage, $"..")

	emit_signal("shot_fired")
