extends Control

@onready var label = $"Panel/DialogLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogManager.connect("line_changed", _on_line_changed)
	DialogManager.connect("dialog_started", _on_dialog_started)
	DialogManager.connect("dialog_ended", _on_dialog_ended)

func _on_line_changed(new_line: String):
	label.text = new_line

func _on_dialog_started():
	self.visible = true

func _on_dialog_ended():
	self.visible = false