extends Node

@onready var player_character = $"../.."
@onready var states = $".."
@onready var jump_component = $"../../JumpComponent"

func enter():
#	print('jumpstate')
	jump_component.perform_jump()

func update(_d):
	pass
	
func p_update(_d):
	pass

func exit():
	pass

