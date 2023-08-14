class_name HitBox extends Area3D

@onready var entity = $".."

@export var team := "enemy"

signal hit

func receive_hit(damage : float, attacker):
	if get_node("hit_snd"):
		get_node("hit_snd").splay()
	hit.emit(damage, attacker)
	
