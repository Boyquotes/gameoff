extends Node2D

func _on_character_health_updated(current_health: int, previous_health: int, max_health: int) -> void:
	var percentage = float(current_health) / max_health
	$Empty.scale.x = 1 - percentage