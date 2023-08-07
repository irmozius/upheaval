extends Control

@onready var game := preload("res://scenes/env/world.tscn")
@onready var start = $VBoxContainer/start

func _ready():
	start.grab_focus()

func _on_button_pressed():
	MusicManager.get_node("drop").mplay()
	get_tree().change_scene_to_packed(game)
