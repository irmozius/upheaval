class_name GravityComponent extends Node3D

@onready var entity : CharacterBody3D = $".."
@onready var states = $"../states"
@onready var jump_component = $"../JumpComponent"
#@onready var player_input = $"../PlayerInput"

@export var apply_gravity := true
@export var gravity_amount := 0.1

var gravity : float
var falling := false

func get_grounded():
	if !apply_gravity: return true
	return entity.is_on_floor()

func _physics_process(_delta):
	gravity = entity.velocity.y
	if !get_grounded():
		jump_component.jumping = false
		falling = true
		gravity -= gravity_amount
		states.change_state("falling")
	else:
		if !jump_component.jumping:
			if falling:
				falling = false
				gravity = 0.0
				states.change_state("idle")
	entity.velocity.y = gravity
