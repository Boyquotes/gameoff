extends ActionLeaf

@export var wait_in_seconds: float = 1

var _has_started = false
var _start_time = -1

func tick(actor: FakePlayer, blackboard: Blackboard):
	if not _has_started:
		_has_started = true
		_start_time = Time.get_ticks_msec()

	if Time.get_ticks_msec() - _start_time >= wait_in_seconds * 1000:
		_has_started = false
		return SUCCESS
	else:
		actor.stop_movement()
		return RUNNING