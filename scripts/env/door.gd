extends Node3D

@export var open := false
@export var locked := false
@export var key_name := ""
@onready var screen = $middle/Screen
@onready var opensnd = $middle/open
@onready var unlocksnd = $middle/unlock
@onready var error = $middle/error

@onready var middle : MeshInstance3D = $middle
@onready var area_3d = $Area3D

func _ready():
	if locked:
		screen.set_text("locked")
		screen.set_colour(Color.ORANGE_RED)
	if open:
		middle.position.y = 13.0
		area_3d.queue_free()

func open_door(instant:=false):
	get_parent().opened_doors.append(get_index())
	area_3d.queue_free()
	if !instant:
		opensnd.play()
		var t := create_tween()
		t.tween_property(middle, 'position:y', 13.0, 1.0).set_trans(Tween.TRANS_SPRING)
	else:
		middle.position.y = 13.0
	
func _on_area_3d_body_entered(body):
	if locked:
		if !(body is PlayerCharacter): return
		var keyring = body.get_node("KeyringComponent")
		var num = keyring.keys.find(key_name)
		if num != -1:
			unlocksnd.play()
			screen.set_text("welcome")
			screen.set_colour(Color("89d174"))
			open_door()
		else:
			error.play()
		return
	if body is PlayerCharacter:
		open_door()
