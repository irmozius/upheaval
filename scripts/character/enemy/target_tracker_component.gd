class_name AI_Tracker extends Node3D

@onready var entity = $".."

var target
var target_pos : Vector3
var target_dir : Vector3
var target_dis : float

func set_target(t):
	target = t
	target.get_node("HealthComponent").died.connect(target_death)

func target_death():
	target = null

func _process(_delta):
	var pos : Vector3 = entity.global_position
	if target:
		target_pos = target.global_position
		target_dir = pos.direction_to(target_pos)
		target_dis = pos.distance_to(target_pos)
