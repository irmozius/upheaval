extends Control

#@onready var menu = preload("res://scenes/system/main_menu.tscn")
@onready var button = $VBoxContainer/retrybut

func reveal():
	show()
	button.grab_focus()

func _on_button_pressed():
	get_tree().reload_current_scene()

func _on_retrybut_2_pressed():
	get_tree().change_scene_to_file("res://scenes/system/main_menu.tscn")
