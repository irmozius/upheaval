extends Node3D

@export var open := false
@export var locked := false
@onready var screen = $middle/Screen

@onready var middle : MeshInstance3D = $middle
@onready var area_3d = $Area3D

func _ready():
	if locked:
		screen.set_text("locked")
		screen.set_colour(Color.ORANGE_RED)
	if open:
		middle.position.y = 13.0
		area_3d.queue_free()

func open_door():
	var t := create_tween()
	t.tween_property(middle, 'position:y', 13.0, 1.0).set_trans(Tween.TRANS_SPRING)
	
func _on_area_3d_body_entered(body):
	if locked: return
	if body is PlayerCharacter:
		open_door()
		area_3d.queue_free()
