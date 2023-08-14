extends Node3D

var killed : Array[int]

func set_killed(nums : Array[int]):
	killed = nums
	for i in killed.size():
		get_child(killed[i]).create_corpse()
