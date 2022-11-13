extends Node

@export var camera_shake_intensity: float = 10.0
@export var camera_shake_duration: float = 0.1

func _ready() -> void:
	GlobalEvents.connect("player_took_damage", _on_player_took_damage)

func _on_player_took_damage(damage: int, origin: Node2D):
	shake_camera(camera_shake_intensity, camera_shake_duration)

func shake_camera(intensity: float, duration: float):
	duration /= 2
	var _camera = Globals.player._camera
	var tween = get_tree().create_tween()
	tween.tween_property(_camera, "offset", Vector2(intensity, 0), duration/2)
	tween.tween_property(_camera, "offset", Vector2(-intensity, 0), duration)
	tween.tween_property(_camera, "offset", Vector2(0, 0), duration/2)
