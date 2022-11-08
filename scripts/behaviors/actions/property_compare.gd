extends ConditionLeaf

@export var property_getter: String = ""
@export var compare_value: int


func tick(actor: Character, blackboard: Blackboard):
	var value
	if actor.has_method(property_getter):
		value = actor.call(property_getter)
	else:
		value = actor.dynamic_fields[property_getter].call()

	if value <= compare_value:
		return SUCCESS
		
	return FAILURE
