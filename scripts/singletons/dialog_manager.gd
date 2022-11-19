extends Node

signal advance_dialog()
signal line_changed(new_line: String)
signal dialog_started()
signal dialog_ended()

var _is_playing = false

var lines = {
	"start_level": Randomizer.new([
		"Let's do this!",
		"Leeroy Jenkiiiins!"
	]),
	"player_health_critical": [
		"Damn, this game is hard, I need to find some health ASAP"
	],
	"player_died": [
		"Crappy game, this is way too hard"
	],
	"test": [
		"line1",
		"line2",
		"line3",
	]
}
class Randomizer:
	var lines = []
	func _init(lines: Array[String]) -> void:
		self.lines = lines

func play(topic: String):
	if not topic in lines:
		push_error("tried to play inexistent topic: %s" % topic)
		return
	
	_is_playing = true
	emit_signal("dialog_started")
	Globals.pause_game()

	var selected_lines = lines[topic]
	if lines[topic] is Randomizer:
		selected_lines = [selected_lines.lines.pick_random()]

	for line in selected_lines:
		print("playing line: %s" % line)
		emit_signal("line_changed", line)
		await advance_dialog
	_is_playing = false
	emit_signal("dialog_ended")
	Globals.resume_game()
	

func _input(event: InputEvent) -> void:
	if _is_playing and event is InputEventKey and event.keycode == KEY_SPACE and not event.pressed:
		emit_signal("advance_dialog")