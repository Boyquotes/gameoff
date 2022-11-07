extends ConditionLeaf


func tick(actor: Character, blackboard: Blackboard):
	if actor.get_item_in_range("enemy") != null:
		return SUCCESS
		
	return FAILURE
