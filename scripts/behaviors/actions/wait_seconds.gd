extends ActionLeaf

@export var wait_in_seconds: float = 1

var _timer = null

func tick(actor: Character, blackboard: Blackboard):
	if _timer == null:
		_timer = get_tree().create_timer(wait_in_seconds)
	
	if _timer.time_left <= 0:
		_timer = null
		return SUCCESS
	else:
		actor.stop_movement()
		return RUNNING