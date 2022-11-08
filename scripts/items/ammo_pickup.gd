extends CharacterBody2D

class_name AmmoPickup

@export var ammo_value = 10

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is FakePlayer:
		body.dynamic_fields["add_ammo"].call(ammo_value)
		queue_free()
