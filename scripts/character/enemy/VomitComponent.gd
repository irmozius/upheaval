extends Node3D

@onready var entity = $"../../../.."

@onready var hurt_box = $HurtBox

func _ready():
	hurt_box.entity = entity
	hurt_box.team = "enemy"
	hurt_box.damage = 20.0
