extends Control

@onready var button = $Button

func reveal():
	show()
	button.grab_focus()

func _on_button_pressed():
	get_tree().reload_current_scene()
