class_name HitBox extends Area3D

@onready var entity = $".."

@export var team := "enemy"

signal hit

func receive_hit(damage : float, attacker):
#	print('hit for %s damage!' % damage)
	hit.emit(damage, attacker)
