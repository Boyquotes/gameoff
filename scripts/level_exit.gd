extends Sprite2D


func _ready() -> void:
	$"%FakePlayer".set_level_exit(self)
