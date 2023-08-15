extends Control

@onready var game := preload("res://scenes/env/world.tscn")
@onready var start = $VBoxContainer/start
@onready var continuebut = $VBoxContainer/continue

func _ready():
	if ResourceLoader.exists("user://save.tres"):
		continuebut.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	await get_tree().create_timer(0.15).timeout
	start.grab_focus()

func _on_button_pressed():
	if ResourceLoader.exists("user://save.tres"):
		print('starting new game, erasing old save')
		ResourceSaver.save(SaveData.new(), "user://save.tres")
	get_tree().change_scene_to_packed(game)
	
func _on_continue_pressed():
	get_tree().change_scene_to_packed(game)
