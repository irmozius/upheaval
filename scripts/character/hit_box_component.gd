class_name HitBox extends Area3D

@onready var entity = $".."

@export var team := "enemy"

signal hit

func receive_hit(damage : float, attacker):
#	print('hit for %s damage!' % damage)
	if team == "enemy":
		print(damage)
	if get_node("hit_snd"):
		get_node("hit_snd").splay()
	hit.emit(damage, attacker)
	
