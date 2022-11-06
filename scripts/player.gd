extends RigidBody2D

@export var speed: float
@export var object_template: PackedScene
@export_flags_2d_physics var collision_layer_mask: int

func _physics_process(delta):
	# input movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.length() > 1:
		direction = direction.normalized()
	direction *= speed * delta
	
	if direction.length() > 0:
		apply_force(direction)
		# old code for kinematic body
		# velocity = direction
		# move_and_slide()

func _place_item(spawn_pos: Vector2):
	var obj = object_template.instantiate()
	obj.global_position = spawn_pos
	$"%ObjectsRoot".add_child(obj)


func _unhandled_input(event: InputEvent):
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
		return

	var pos = get_global_mouse_position()

	var query = PhysicsRayQueryParameters2D.create(pos, pos + Vector2(1,0), collision_layer_mask)
	query.hit_from_inside = true
	var collision = get_world_2d().direct_space_state.intersect_ray(query) # TODO should do a shapecast with a circle for better precision

	if "position" in collision:
		print("not spawning item because colliding")
		return
		
	_place_item(pos)
