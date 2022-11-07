extends ConditionLeaf

@export var item_type: String = "" # TODO should use enum for types, or maybe groups


func tick(actor: Character, blackboard: Blackboard):
	if actor.get_item_in_range(item_type):
		return SUCCESS
		
	return FAILURE
