extends ActionLeaf


@export var item_type: String = "" # TODO should use enum for types, or maybe groups


func tick(actor: Character, blackboard: Blackboard):
	var item = actor.get_item_in_range(item_type)
	if item == null:
		return FAILURE
		
	actor.change_target_destination(item.global_position)
	if actor.has_reached_target():
		actor.stop_movement()
		return SUCCESS

	actor.resume_movement()
	return RUNNING
