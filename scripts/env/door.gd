extends Node3D

@export var open := false
@export var locked := false
@export var key_name := ""
@onready var screen = $middle/Screen
@onready var opensnd = $middle/open
@onready var unlocksnd = $middle/unlock
@onready var error = $middle/error
@onready var messager = get_tree().get_first_node_in_group("message_label")

@onready var middle : MeshInstance3D = $middle
@onready var area_3d = $Area3D

func _ready():
	if locked:
		if key_name != "":
			screen.set_text("locked")
		else:
			screen.set_text("ERROR")
		screen.set_colour(Color.ORANGE_RED)
	if open:
		middle.position.y = 13.0
		area_3d.queue_free()

func open_door(instant:=false):
	if get_parent().has_method("set_doors"):
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
			messager.display_message("unlocked with\n%s" % key_name)
		else:
			error.play()
			if key_name == "":
				messager.display_message("door is\nbusted")
			else:
				messager.display_message("need\n%s" % key_name)
				await get_tree().create_timer(0.4).timeout
				screen.set_text(key_name)
				await get_tree().create_timer(0.8).timeout
				screen.set_text("locked")
		return
	if body is PlayerCharacter:
		open_door()
