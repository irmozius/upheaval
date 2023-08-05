extends Node

@onready var entity = $"../.."
@onready var states = $".."
@onready var anim = $"../../AnimationComponent"
@onready var motion = $"../../MotionComponent"
@onready var decider = $"../../AttackDeciderComponent"

var active := false
var a_name := ""

func enter():
	anim.play(a_name)
	anim.animation_finished.connect(anim_end)
	a_name = ""
	active = true

func update(_d):
	motion.move(Vector3.ZERO)
	
func p_update(_d):
	pass

func anim_end(_anim_name):
	if !active: return
	decider.timer.start()
	active = false
	anim.animation_finished.disconnect(anim_end)
	states.change_state("idle")

func exit():
	pass
