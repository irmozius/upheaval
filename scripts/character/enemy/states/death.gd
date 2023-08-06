extends Node

@onready var entity = $"../.."
@onready var states = $".."
@onready var anim = $"../../AnimationComponent"

func enter():
	anim.play("death")

func update(_d):
	pass
	
func p_update(_d):
	pass

func exit():
	pass

