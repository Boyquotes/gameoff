extends CharacterBody2D

class_name Character

signal received_damage(damage: int, receiver: Character, origin: Character)
signal has_died
signal path_changed

@export var health_start: int = 100
@export var ai_debug_visible = false
@export var speed: float

@onready var _health_current = health_start
var _enemies_in_range: Dictionary = {}
var _friendlies_in_range: Dictionary = {}#

var _current_target: Node2D
var _moving_towards_target = false


func _on_received_damage(damage: int, _receiver: Character, origin: Character) -> void:
	_health_current -= damage
	if _health_current <= 0:
		_die()

func _die():
	emit_signal("has_died")
	queue_free()

func debug_ai_state(debug_text: String):
	if ai_debug_visible:
		print("AI: %s" % debug_text)

func _on_sprite_animation_finished() -> void:
	# using this instead of controller for simplicity
	if $Sprite.animation == "fire":
		# print("move to idle animation")
		$Sprite.play("idle")
	pass

# SHOOTING
func shoot():
	if _current_target:
		$Sprite.flip_h = _current_target.global_position.x - global_position.x < 0
		$MachineGunWeapon.shoot(_current_target)

func _on_machine_gun_weapon_shot_fired() -> void:
	if $Sprite.animation != "fire":
		# print("changing animation to fire")
		$Sprite.play("fire")
	pass
			
func has_enemies_in_range():
	return len(_enemies_in_range) > 0

func _refresh_target():
	# TODO choose closest
	if not _current_target and len(_enemies_in_range) > 0:
		_current_target = _enemies_in_range.values()[0]

func _acquire_target(enemy: Character):
	_current_target = enemy

func _remove_target(enemy: Character):
	_current_target = null

# NAVIGATION
func change_target_destination(new_target: Vector2):
	$NavigationAgent2D.set_target_location(new_target)
	$NavigationAgent2D.get_next_location()
	emit_signal("path_changed")

func resume_movement():
	_moving_towards_target = true

func stop_movement():
	_moving_towards_target = false

func has_reached_target() -> bool:
	# print($NavigationAgent2D.is_navigation_finished())
	return $NavigationAgent2D.is_target_reached()

func _navigate_towards_target(delta):
	if has_reached_target():
		return
	var next = $NavigationAgent2D.get_next_location()
	var towards_next = next - global_position
	_move_towards(towards_next, delta)
	
func _move_towards(direction: Vector2, delta: float):
	# print("_move_towards") # TODO bug shouldn't be called when firing
	if direction.length() > 1:
		direction = direction.normalized()
	direction *= speed * delta
	
	if direction.length() > 0:
		velocity = direction
		move_and_slide()
		$Sprite.flip_h = direction.x < 0
		# $Sprite.play("walk") # TODO animation not working when walking
	else: 
		# $Sprite.play("idle")
		pass