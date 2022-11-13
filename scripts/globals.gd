extends Node

var _player: Player
var fake_player: FakePlayer
var objects_root: Node2D
var spawner: SpawnerManager

var player: Player:
	get:
		return _player
	set(value):
		_player = value

