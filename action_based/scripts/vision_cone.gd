extends Node2D


@export var ray_count = 100
@export var angle = 2*PI
@export var max_distance = 500
@export var collision_layer_mask: int = 0

@export var debug_lines = false
@export var debug_shape = false

var _vision_points: Array[Vector2]


func _process(_delta: float) -> void:
	_recalculate_vision()
	queue_redraw()


func _draw():
	if len(_vision_points) == 0:
		return 
	var from = _vision_points[0]
	var to: Vector2
	for i in range(1, len(_vision_points)):
		to = _vision_points[i]
		if debug_shape:
			draw_line(from, to, Color.GREEN)
		if debug_lines:
			draw_line(Vector2.ZERO, to, Color.BLUE)
		from = to
	

func _recalculate_vision():
	_vision_points.clear()
	
	var angular_delta = angle / ray_count
	for i in range(ray_count): 
		_ray(Vector2(0, max_distance).rotated(angular_delta * i))


func _ray(direction: Vector2):
	var destination = global_position + direction
	var query = PhysicsRayQueryParameters2D.create(global_position, destination, collision_layer_mask)
	var collision = get_world_2d().direct_space_state.intersect_ray(query)

	var ray_position = collision["position"] if "position" in collision else destination
	_vision_points.append(to_local(ray_position))
