extends ActionLeaf


func tick(actor: Character, blackboard: Blackboard):
	actor.stop_movement()
	actor.shoot()
	if actor.get_item_in_range("enemy") != null:
		return RUNNING
	return SUCCESS
