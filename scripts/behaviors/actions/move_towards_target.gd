extends ActionLeaf

@export var distance_threshold = 1
@export var destination: NodePath

func tick(actor: FakePlayer, blackboard: Blackboard):
	if actor.has_reached_target():
		return SUCCESS

	actor.resume_movement()
	return RUNNING
