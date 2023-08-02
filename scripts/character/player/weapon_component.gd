class_name PlayerWeapons extends Node3D

@onready var player = $".."
@onready var cast = $"../RayCast3D"
@onready var weapon = $pistol

var arsenal : Array

func weapon_attack(type : String):
	weapon.shoot()

func change_weapon():
	pass
