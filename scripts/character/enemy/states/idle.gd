extends Node

@onready var entity = $"../.."
@onready var states = $".."
@onready var motion = $"../../MotionComponent"
@onready var tracker = $"../../TargetTrackerComponent"

func enter():
	pass

func update(_d):
	motion.move(Vector3.ZERO)
	if tracker.target:
		states.change_state("chasing")
	
func p_update(_d):
	pass

func exit():
	pass

