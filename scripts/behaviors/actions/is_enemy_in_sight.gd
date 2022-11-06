extends ConditionLeaf


func tick(actor: FakePlayer, blackboard: Blackboard):
	if actor.has_enemies_in_range():
		return SUCCESS
		
	return FAILURE
