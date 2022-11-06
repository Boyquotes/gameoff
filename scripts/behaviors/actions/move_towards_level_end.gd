extends ActionLeaf

@export var distance_threshold = 1
@export var destination: NodePath

func tick(actor: FakePlayer, blackboard: Blackboard):
	var target_position = get_node(destination).global_position
	actor.change_target_destination(target_position)
	actor.debug_ai_state("Moving towards %s" % target_position)

	# if reach objective set back to false
	if (actor.global_position - target_position).length() < distance_threshold:
		actor.stop_movement()
		return SUCCESS
