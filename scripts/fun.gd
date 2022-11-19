extends Node

signal fun_updated(current: float, previous: float, max_value: float)

@export var fun_max: float
@export var fun_start: float
@export var fun_gain_mg_shot: float
@export var fun_gain_enemy_killed: float = 20
@export var fun_decay_per_second: float

@onready var _fun_current: float = fun_start

func _ready() -> void:
	emit_signal("fun_updated", _fun_current, _fun_current, fun_max)
	GlobalEvents.connect("enemy_died", _on_enemy_died)

func add_fun(delta):
	var old = _fun_current
	_fun_current += delta
	_fun_current = min(_fun_current, fun_max)
	_fun_current = max(_fun_current, 0)
	emit_signal("fun_updated", _fun_current, old, fun_max)

func _on_machine_gun_weapon_shot_fired() -> void:
	add_fun(fun_gain_mg_shot)

func _on_timer_timeout():
	add_fun(-fun_decay_per_second)

func _on_enemy_died(enemy):
	add_fun(fun_gain_enemy_killed)