extends Node2D

@export var variable_name: String = ""

func _ready() -> void:
	if variable_name == "":
		variable_name = name
	Globals[variable_name] = self

