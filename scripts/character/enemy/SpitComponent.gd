extends Node3D

@onready var entity = $"../../../.."
@onready var spit_res = preload("res://scenes/weapons/wriggler_spit.tscn")
@onready var spawn_pos = $Marker3D
@onready var tracker = $"../../../../TargetTrackerComponent"
@onready var proot = get_tree().get_first_node_in_group("proj")

func launch_spit():
	var spit = spit_res.instantiate()
	var pos = spawn_pos.global_position
	var aim_pos = tracker.aim_pos + Vector3(randf_range(-1,1),randf_range(1.5,2),randf_range(-1,1))
	var dir = pos.direction_to(aim_pos)
	spit.init(spawn_pos.global_position, dir, "enemy", 15.0, entity)
	proot.add_child(spit)
