extends ActionLeaf

@export var distance_threshold = 1
@export var destination: NodePath

func tick(actor: Character, blackboard: Blackboard):
	var destination_node = get_node(destination)
	if destination_node == null:
		return SUCCESS
	
	var target_position = destination_node.global_position
	actor.change_target_destination(target_position)

	if (actor.global_position - target_position).length() < distance_threshold:
		actor.stop_movement()
		return SUCCESS
	
	return RUNNING
