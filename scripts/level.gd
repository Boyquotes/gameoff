extends Node2D

@export var tutorial_enabled = true

var _player_health_critical_first_time = true

# TODO maybe rename to TutorialManager
func _ready() -> void:
	DialogManager.play("start_level")

	GlobalEvents.connect("player_health_critical", _on_player_health_critical)
	GlobalEvents.connect("player_died", _on_player_died)

func _on_player_health_critical():
	if not _player_health_critical_first_time or not tutorial_enabled:
		return
	_player_health_critical_first_time = false
	DialogManager.play("player_health_critical")

func _on_player_died():
	await DialogManager.play("player_died")
	get_tree().reload_current_scene()