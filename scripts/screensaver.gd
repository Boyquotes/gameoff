extends Node2D

func _on_fake_player_just_died(actor) -> void:
	Globals.change_timescale(1)
	get_tree().reload_current_scene()
