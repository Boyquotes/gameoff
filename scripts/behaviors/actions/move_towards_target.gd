extends ActionLeaf

@export var distance_threshold = 1
@export var destination: NodePath

func tick(actor: Character, blackboard: Blackboard):
	if actor.has_reached_target():
		actor.stop_movement()
		return SUCCESS

	actor.resume_movement()
	return RUNNING
