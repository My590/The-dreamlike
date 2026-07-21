extends Node

@onready var panel = $CanvasLayer/Panel
@onready var label = $CanvasLayer/Panel/Label

func show_message(text):
	label.text = text
	panel.visible = true

	await get_tree().create_timer(3).timeout

	panel.visible = false
	
"""


"""
