extends Control

@onready var label = $Label

func _ready():
	visible = false

func show_message(text: String):
	label.text = text
	visible = true
	get_tree().paused = true
