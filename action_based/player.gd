extends CharacterBody2D

@export var speed: float

@export var nav_path_tolerance: float

var _nav_path = []
var nav_path_idx = 0

func _physics_process(delta):
	# pathfinding movement
	_nav_path = $NavigationAgent2D.get_nav_path()
	if len(_nav_path) == 0 or nav_path_idx >= len(_nav_path): # TODO refactor extract this condition
		return
		
	var next = _nav_path[nav_path_idx]
	var distance: Vector2 = global_position - next
	if distance.length() < nav_path_tolerance:
		nav_path_idx += 1
		if nav_path_idx >= len(_nav_path):
			return
		next = _nav_path[nav_path_idx]
	var towards_next = next - global_position
	move_towards(towards_next, delta)
	queue_redraw()
	
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

func _draw():
	var points = $NavigationAgent2D.get_nav_path()
	if len(points) == 0:
		return
	var s = to_local(points[0])
	for i in range(1, len(points)):
		draw_line(s, to_local(points[i]), Color.RED)
		s = to_local(points[i])
		
	if len(_nav_path) == 0 or nav_path_idx >= len(_nav_path):
		return
	var next = to_local(_nav_path[nav_path_idx])
	draw_line(Vector2.ZERO, next, Color.MAGENTA, 3)


func _on_path_changed() -> void:
	# _nav_path = $NavigationAgent2D.get_nav_path()
	nav_path_idx = 0
