extends Node

signal player_took_damage(damage: int, origin: Node2D)
signal player_died()
signal explosion_happened(position: Vector2)
signal spawn_requested(position: Vector2, item: SpawnableItem)
signal spawn_completed(position: Vector2, item: SpawnableItem)

signal player_health_critical()
signal player_ammo_critical()

signal game_paused()
signal game_resumed()


func _ready() -> void:
	Globals.fake_player.connect("received_damage", _on_player_took_damage)

func _on_player_took_damage(damage: int, _receiver: Node2D, origin: Node2D):
	emit_signal("player_took_damage", damage, origin)
