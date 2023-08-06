extends Node

@onready var player_input = $"../../PlayerInput"
@onready var states = $".."
@onready var motion = $"../../MotionComponent"
@onready var weapon_component = $"../../Camera3D/WeaponComponent"
@onready var health_component = $"../../HealthComponent"


func enter():
	pass

func update(_d):
	if health_component.hp <= 0.0:
		return
	var motion_input = player_input.movement()
	
	motion.move(motion_input)
	if motion.velocity.length() < 0.5:
		states.change_state("idle")
	
	var action_input : String = player_input.actions()
	match action_input:
		"jump":
			states.change_state("jumping")
		"shoot":
			weapon_component.weapon_attack("light")
		"reload":
			weapon_component.weapon_reload()
		"change_wep":
			weapon_component.change_weapon()

func p_update(_d):
	pass

func exit():
	pass

