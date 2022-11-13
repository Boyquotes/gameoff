extends Node

signal player_took_damage(damage: int, origin: Node2D)
signal explosion_happened(position: Vector2)

func _ready() -> void:
	Globals.fake_player.connect("received_damage", _on_player_took_damage)

func _on_player_took_damage(damage: int, _receiver: Node2D, origin: Node2D):
	emit_signal("player_took_damage", damage, origin)
