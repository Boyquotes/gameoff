extends CharacterBody2D

var _vision_points: Array[Vector2]

@export var speed: float

func _physics_process(delta):
	var input_velocity = Input.get_vector("player_move_left", "player_move_right", "player_move_up", "player_move_down")
	
	if input_velocity.length() > 1:
		input_velocity = input_velocity.normalized()
	input_velocity *= speed * delta
	
	if input_velocity.length() > 0:
		velocity = input_velocity
		move_and_slide()
		$Sprite.flip_h = input_velocity.x < 0
		$Sprite.play("walk")
	else: 
		$Sprite.play("idle")
		
	_draw_vision()
	queue_redraw()
	
	# pathfinding
	var next = $NavigationAgent2D.get_next_location()
	global_position = next

# TODO separate vision logic, key movement and path movement
func _ready():
	pass
	NavigationServer2D
	
func _draw_vision():
	_vision_points.clear()
	var ray_count = 100
	var angle = 2*PI
	var max_distance = 500
	
	var angular_delta = angle / ray_count
	for i in range(ray_count): 
		ray(Vector2(0, max_distance).rotated(angular_delta * i))

func ray(direction: Vector2):
	var destination = global_position + direction
	var query = PhysicsRayQueryParameters2D.create(global_position, destination)
	var collision = get_world_2d().direct_space_state.intersect_ray(query)
	
	var ray_position = collision["position"] if "position" in collision else destination
	_vision_points.append(ray_position - global_position)
#	print("added %s" % (ray_position - global_position))
	
#	var sprite = debug_sprite.instantiate()
#	self.add_child(sprite)
#	sprite.global_position = ray_position
	
func _draw():
	var from = _vision_points[0]
	var to: Vector2
	for i in range(1, len(_vision_points)):
		to = _vision_points[i]
		draw_line(from, to, Color.GREEN)
		from = to
		
	var points = $NavigationAgent2D.get_nav_path()
	if len(points) == 0:
		return
	var s = to_local(points[0])
	for i in range(1, len(points)):
		draw_line(s, to_local(points[i]), Color.RED)
		s = to_local(points[i])

func _unhandled_input(event: InputEvent):
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed):
		return
		
	$NavigationAgent2D.set_target_location(get_global_mouse_position())
