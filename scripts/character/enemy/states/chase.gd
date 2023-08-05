extends Node

@onready var entity = $"../.."
@onready var states = $".."
@onready var tracker : AI_Tracker = $"../../TargetTrackerComponent"
@onready var decider = $"../../AttackDeciderComponent"
@onready var motion = $"../../MotionComponent"
@onready var rotator = $"../../RotatorComponent"
@onready var weapon = $"../../weapon/WeaponComponent"
@onready var anim = $"../../AnimationComponent"

func enter():
	pass
	
func update(_d):
	if !tracker.target:
		states.change_state("idle")
		return
	rotator.face_dir(tracker.aim_pos)
	if tracker.target_dis > 5.0:
		anim.play("walk")
		motion.move(tracker.target_dir)
	else:
		anim.play("idle")
		motion.move(Vector3.ZERO)
	if tracker.target_dis < decider.max_range:
		var decision : AttackEntry = decider.decide()
		if !decision: return
		match decision.type:
			"Animation":
				states.get_node("attack_anim").a_name = decision.anim_name
				states.change_state("attack_anim")
			"Weapon":
				if weapon.weapon.can_fire:
					weapon.weapon_attack("light")

func p_update(_d):
	pass

func exit():
	pass

