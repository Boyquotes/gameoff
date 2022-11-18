extends Button

var _index: int
var _player: Node2D

func init(item: SpawnableItem, idx: int, player: Node2D):
	text = item.name
	_index = idx
	_player = player
	$CountLabel.text = str(item.count)


func _on_pressed() -> void:
	# TODO could be more generic by emitting a signal with a dict of values instead of tying it to a specific method
	_player.select_item(_index)
