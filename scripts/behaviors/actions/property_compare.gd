extends ConditionLeaf

@export var property_getter: String = ""
@export var compare_value: int
@export var signal_name_succes: String = "" # signal name to call on GlobalEvents when the condition is true


func tick(actor: Character, blackboard: Blackboard):
	var value
	if actor.has_method(property_getter):
		value = actor.call(property_getter)
	else:
		value = actor.dynamic_fields[property_getter].call()

	if value <= compare_value:
		if signal_name_succes != "":
			GlobalEvents.emit_signal(signal_name_succes)
		return SUCCESS
		
	return FAILURE
