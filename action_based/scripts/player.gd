extends CharacterBody2D

@export var speed: float

func _physics_process(delta):
	# input movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.length() > 1:
		direction = direction.normalized()
	direction *= speed * delta
	
	if direction.length() > 0:
		# apply_force(direction)
		velocity = direction
		move_and_slide()