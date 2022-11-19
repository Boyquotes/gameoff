extends Node

var _player: Player
var fake_player: FakePlayer
var objects_root: Node2D
var spawner: SpawnerManager
var is_game_paused = false

var player: Player:
	get:
		return _player
	set(value):
		_player = value

func pause_game():
	Engine.time_scale = 0
	is_game_paused = true
	GlobalEvents.emit_signal("game_paused")

func resume_game():
	Engine.time_scale = 1
	is_game_paused = false
	GlobalEvents.emit_signal("game_resumed")

func restart_game():
	Globals.change_timescale(1)
	get_tree().reload_current_scene()

func change_timescale(value: float):
	if Globals.is_game_paused:
		await GlobalEvents.game_resumed
	Engine.time_scale = value