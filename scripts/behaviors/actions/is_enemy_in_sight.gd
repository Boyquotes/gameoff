extends ConditionLeaf

@export var item_type = "enemy"

func tick(actor: Character, blackboard: Blackboard):
	if actor.get_item_in_range(item_type) != null:
		return SUCCESS
		
	return FAILURE
