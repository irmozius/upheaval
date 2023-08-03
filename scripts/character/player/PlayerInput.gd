class_name PlayerInput extends Node

@onready var player = $".."
@onready var rotator_component = $"../RotatorComponent"

func _input(event):
	if event is InputEventMouseMotion:
		var rot = event.relative
		rot.x *= -1
		rotator_component.rotate_entity(rot)

func movement() -> Vector3:
	var input_dir = Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down")
	var direction = (player.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	return direction
	
func actions() -> String:
	var action := "none"
	
	if Input.is_action_just_pressed("mv_jump"):
		action = "jump"
	if Input.is_action_pressed("shoot_normal"):
		action = "shoot"
	if Input.is_action_just_pressed("shoot_heavy"):
		action = "heavy"
	if Input.is_action_just_pressed("reload"):
		action = "reload"
	if Input.is_action_just_pressed("change_wep"):
		action = "change_wep"
	
	return action
