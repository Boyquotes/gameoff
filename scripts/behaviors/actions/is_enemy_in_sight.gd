extends ConditionLeaf


func tick(actor: FakePlayer, blackboard: Blackboard):
	if len(actor._enemies_in_range):
		actor.debug_ai_state("Enemies are in range from behavior tree")
		return SUCCESS
		
		actor.debug_ai_state("NO enemies are in range from behavior tree")
	return FAILURE
