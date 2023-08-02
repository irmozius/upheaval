extends Node

@onready var entity = $"../.."
@onready var states = $".."
@onready var tracker : AI_Tracker = $"../../TargetTrackerComponent"
@onready var motion = $"../../MotionComponent"
@onready var rotator = $"../../RotatorComponent"
@onready var weapon = $"../../weapon/WeaponComponent"

func enter():
	pass

func update(_d):
	if !tracker.target:
		states.change_state("idle")
		return
	rotator.face_dir(tracker.target_pos)
	if tracker.target_dis > 12.0:
		motion.move(tracker.target_dir)
	else:
		motion.move(Vector3.ZERO)
	if tracker.target_dis < 50:
		if weapon.weapon.can_fire:
			weapon.weapon_attack("light")

func p_update(_d):
	pass

func exit():
	pass

