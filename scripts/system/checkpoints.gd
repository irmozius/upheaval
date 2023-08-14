extends Node3D

var found_list : Array[int]

func set_checkpoints(nums : Array[int]):
	found_list = nums
	for i in found_list.size():
		get_child(found_list[i]).passed = true
