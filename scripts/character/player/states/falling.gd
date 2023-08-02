extends Node

@onready var player_character = $"../.."
@onready var motion = $"../../MotionComponent"
@onready var player_input = $"../../PlayerInput"

func enter():
	pass

func update(_d):
	var motion_input = player_input.movement()
	motion.move(motion_input)
	
func p_update(_d):
	pass

func exit():
	pass

