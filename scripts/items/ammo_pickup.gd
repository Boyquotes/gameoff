extends CharacterBody2D

class_name AmmoPickup

@export var ammo_value = 10

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is FakePlayer:
		body.add_ammo(ammo_value)
		queue_free()
