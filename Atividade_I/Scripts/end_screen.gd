extends Control

func _ready():
	visible = false

func show_message(text: String):
	$Label.text = text
	visible = true
