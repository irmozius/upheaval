extends Node3D

var found_list : Array[int]

func set_pickups(nums : Array[int]):
	found_list = nums
	print(str(found_list))
	for i in found_list.size():
		get_child(found_list[i]).disable()
