extends CharacterBody2D

@export var speed: float

@export var nav_path_tolerance: float

var nav_path = []
var nav_path_idx = 0

func _physics_process(delta):
	# input movement
	var input_velocity = Input.get_vector("player_move_left", "player_move_right", "player_move_up", "player_move_down")
#	move_towards(input_velocity, delta)
	
	
	# pathfinding movement
	nav_path = $NavigationAgent2D.get_nav_path()
	if len(nav_path) == 0 or nav_path_idx >= len(nav_path): # TODO refactor extract this condition
		return
		
	var next = nav_path[nav_path_idx]
	var distance: Vector2 = global_position - next
	if distance.length() < nav_path_tolerance:
		nav_path_idx += 1
		if nav_path_idx >= len(nav_path):
			return
		next = nav_path[nav_path_idx]
	var towards_next = next - global_position
	move_towards(towards_next, delta)
	
func move_towards(direction: Vector2, delta: float):
	if direction.length() > 1:
		direction = direction.normalized()
	direction *= speed * delta
	
	if direction.length() > 0:
		velocity = direction
		move_and_slide()
		$Sprite.flip_h = direction.x < 0
		$Sprite.play("walk")
	else: 
		$Sprite.play("idle")
		

# TODO separate vision logic, key movement and path movement
func _ready():
	Engine.time_scale = 1
	
func _draw():
		
	var points = $NavigationAgent2D.get_nav_path()
	if len(points) == 0:
		return
	var s = to_local(points[0])
	for i in range(1, len(points)):
		draw_line(s, to_local(points[i]), Color.RED)
		s = to_local(points[i])
		
	## 
#	var next = to_local($NavigationAgent2D.get_next_location())
	if len(nav_path) == 0 or nav_path_idx >= len(nav_path):
		return
	var next = to_local(nav_path[nav_path_idx])
	draw_line(Vector2.ZERO, next, Color.MAGENTA, 3)

func _unhandled_input(event: InputEvent):
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed):
		return
		
	$NavigationAgent2D.set_target_location(get_global_mouse_position())
	nav_path = $NavigationAgent2D.get_nav_path()
	nav_path_idx = 0
	$NavigationAgent2D.get_next_location()
