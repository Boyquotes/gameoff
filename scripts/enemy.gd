extends Character

class_name Enemy

signal player_entered_target_area
signal player_exited_target_area

var _target: Node2D

func _process(delta: float) -> void:
	if _target:
		$MachineGunWeapon.shoot(_target)


func _on_player_entered_target_area(player: Node2D) -> void:
	_target = player

func _on_player_exited_target_area() -> void:
	_target = null
