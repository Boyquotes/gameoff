extends ActionLeaf


func tick(actor: FakePlayer, blackboard: Blackboard):
	actor.debug_ai_state("Shooting enemy from behavior tree")
	actor.shoot()
	actor.stop_movement()
