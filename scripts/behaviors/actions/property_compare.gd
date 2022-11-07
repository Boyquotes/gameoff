extends ConditionLeaf

@export var property_getter: String = ""
@export var compare_value: int


func tick(actor: Character, blackboard: Blackboard):
	if actor.call(property_getter) <= compare_value:
		return SUCCESS
		
	return FAILURE
