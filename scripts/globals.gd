extends Node

var _player: Player
var fake_player: FakePlayer

var player: Player:
	get:
		return _player
	set(value):
		_player = value

