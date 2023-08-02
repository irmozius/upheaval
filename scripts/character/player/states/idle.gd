extends Node

@onready var player_input : PlayerInput = $"../../PlayerInput"
@onready var states = $".."
@onready var motion = $"../../MotionComponent"

@onready var weapon_component = $"../../Camera3D/WeaponComponent"

func enter():
	pass

func update(_d):
	var motion_input : Vector3 = player_input.movement()
	if motion_input != Vector3.ZERO:
		motion.move(motion_input)
		states.change_state("motion")
		return
	else:
		motion.move(Vector3.ZERO)
	
	var action_input : String = player_input.actions()
	match action_input:
		"jump":
			states.change_state("jumping")
		"shoot":
			weapon_component.weapon_attack("light")
	
func p_update(_d):
	pass

func exit():
	pass
