extends ActionLeaf


func tick(actor: Character, blackboard: Blackboard):
	actor.stop_movement()
	actor.shoot()
	if actor.has_enemies_in_range():
		return RUNNING
	return SUCCESS
