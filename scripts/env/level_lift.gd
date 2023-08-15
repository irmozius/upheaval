extends Node3D

@export var marquee_text := ""

#@onready var menu = preload()
@onready var sign = $sign
@onready var black = $ColorRect
@onready var door = $door
@onready var menubut = $ColorRect/menubut

func _ready():
	sign.sign_text = marquee_text

func end_level(player):
	MusicManager.win.emit()
	SaveManager.save_data(player, self)
	var t = create_tween()
	t.tween_property(black, 'modulate:a', 1.0, 2.0)
	menubut.grab_focus()
	
func _on_area_3d_body_entered(body):
	if body is PlayerCharacter:
		end_level(body)

func _on_menubut_pressed():
	get_tree().change_scene_to_file("res://scenes/system/main_menu.tscn")
