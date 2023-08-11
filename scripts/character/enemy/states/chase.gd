extends Node

@export var weapon : Node
@export var close_range := 5.0

@onready var entity = $"../.."
@onready var states = $".."
@onready var tracker : AI_Tracker = $"../../TargetTrackerComponent"
@onready var decider = $"../../AttackDeciderComponent"
@onready var motion = $"../../MotionComponent"
@onready var rotator = $"../../RotatorComponent"
@onready var anim = $"../../AnimationComponent"
@onready var sounds_component = $"../../SoundsComponent"
@onready var health_component = $"../../HealthComponent"
@onready var detector = $"../../AIDetectionComponent"

func enter():
	sounds_component.start_barks()
	
func update(_d):
	if health_component.hp <= 0.0:
		return
	if !tracker.target:
		states.change_state("idle")
		return
	rotator.face_dir(tracker.aim_pos)
	if tracker.target_dis > close_range:
		anim.play("walk")
		motion.move(tracker.target_dir)
	else:
		anim.play("idle")
		motion.move(Vector3.ZERO)
	if tracker.target_dis < decider.max_range:
		var decision : AttackEntry = decider.decide()
		var visible : bool = detector.can_see
		if !decision or !visible: return
		sounds_component.stop_barks()
		match decision.type:
			"Animation":
				states.get_node("attack_anim").a_name = decision.anim_name
				states.change_state("attack_anim")
			"Weapon":
				if weapon.weapon.can_fire:
					weapon.weapon_attack("light")
				elif weapon.weapon.clip == 0 and (weapon.weapon.get_stockpile() > 0):
					weapon.weapon_reload()

func p_update(_d):
	pass

func exit():
	pass

