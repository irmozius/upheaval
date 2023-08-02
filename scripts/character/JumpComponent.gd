extends Node3D

@onready var entity = $".."

@export var jump_velocity := 4.0

signal jumped

var jumping := false

func perform_jump():
	jumping = true
	entity.velocity.y = jump_velocity
