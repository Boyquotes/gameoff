extends Node

signal ammo_updated(current_ammo: int, previous_ammo: int, max_ammo: int)

@export var ammo_start: int = 100
@onready var _ammo_current = ammo_start

var _current_target: Node2D

func _ready() -> void:
	$"..".dynamic_fields["shoot"] = shoot
	$"..".dynamic_fields["get_ammo"] = get_ammo
	$"..".dynamic_fields["add_ammo"] = add_ammo

func add_ammo(value: int):
	_ammo_current += value
	_ammo_current = min(_ammo_current, ammo_start)
	_ammo_current = max(_ammo_current, 0)
	emit_signal("ammo_updated", _ammo_current, _ammo_current - value, ammo_start) # TODO old value might be wrong if clamped

func get_ammo():
	return _ammo_current

# SHOOTING
func shoot():
	if _current_target == null or not is_instance_valid(_current_target):
		_refresh_target()

	if _current_target:
		$"../Sprite".flip_h = _current_target.global_position.x - $"..".global_position.x < 0
		$MachineGunWeapon.shoot(_current_target)

func _on_machine_gun_weapon_shot_fired() -> void:
	if $"../Sprite".animation != "fire":
		# print("changing animation to fire")
		$"../Sprite".play("fire")

func _refresh_target():
	# TODO choose closest
	_current_target = $"..".get_item_in_range("enemy")