extends ActionLeaf


func tick(actor: Character, blackboard: Blackboard):
	actor.stop_movement()
	actor.dynamic_fields["shoot"].call()
	if actor.get_item_in_range("enemy") != null:
		return RUNNING
	return SUCCESS
