extends Node

@onready var entity = $"../.."
@onready var states = $".."
@onready var motion = $"../../MotionComponent"
@onready var tracker = $"../../TargetTrackerComponent"
@onready var anim = $"../../AnimationComponent"
@onready var sounds_component = $"../../SoundsComponent"

func enter():
	sounds_component.start_barks()
	anim.play("idle")

func update(_d):
	motion.move(Vector3.ZERO)
	if tracker.target:
		states.change_state("chasing")
	
func p_update(_d):
	pass

func exit():
	pass

