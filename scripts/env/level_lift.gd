extends Node3D

@export var marquee_text := ""

@onready var sign = $sign
@onready var black = $ColorRect
@onready var door = $door

func _ready():
	sign.sign_text = marquee_text

func end_level(player):
	SaveManager.save_data(player, self)
	var t = create_tween()
	t.tween_property(black, 'modulate:a', 1.0, 2.0)
	
	
func _on_area_3d_body_entered(body):
	if body is PlayerCharacter:
		end_level(body)
