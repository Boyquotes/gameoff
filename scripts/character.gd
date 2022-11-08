extends Actor

class_name Character

signal path_changed

@export var ai_debug_visible = false
@export var speed: float

var _things_in_range: Dictionary = {}

var _current_target: Node2D # TODO remove or rename
var _moving_towards_target = false



func add_ammo(value: int):
	pass

func get_ammo():
	return 1

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

func _refresh_target():
	# TODO choose closest
	# TODO revisit logic
	if not _current_target and get_item_in_range("enemy") != null:
		_current_target = get_item_in_range("enemy")

func _acquire_target(enemy: Node2D):  # TODO is this really needed?
	_current_target = enemy

func _remove_target(enemy: Node2D):
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

# TARGETING
func get_item_in_range(item_type: String):
	if _things_in_range.has(item_type):
		var values = _things_in_range.get(item_type).values()
		return values[0] if len(values) > 0 else null

func _node_to_type(node: Node2D):
	if node.is_in_group("player"):
		return "player"
	if node.is_in_group("enemy"):
		return "enemy"
	if node.is_in_group("ammo_pickup"):
		return "ammo"
	if node.is_in_group("health_pickup"):
		return "health"
	if node.is_in_group("barrel"):
		return "barrel"
	return null

func _map_type(type_name): # TODO rename
	return type_name

func _on_visibility_area_body_entered(body: Node2D) -> void:
	var type = _map_type(_node_to_type(body))
	# debug_ai_state("%s: target entered %s with type %s" % [self, body, type])
	if type == null:
		return
	if type == "enemy":
		_acquire_target(body)
	if not _things_in_range.has(type):
		_things_in_range[type] = {}
	_things_in_range[type][body.get_instance_id()] = body

func _on_visibility_area_body_exited(body: Node2D) -> void:
	var type = _map_type(_node_to_type(body))
	if type == null:
		return
	_things_in_range[type].erase(body.get_instance_id())
	if type == "enemy":
		_remove_target(body)

func _on_visibility_area_area_exited(area:Area2D) -> void:
	_on_visibility_area_body_exited(area.get_parent())

func _on_visibility_area_area_entered(area:Area2D) -> void:
	_on_visibility_area_body_entered(area.get_parent())
