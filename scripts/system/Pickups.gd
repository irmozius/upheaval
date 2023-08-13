extends Node3D

var found_list : Array[int]

func set_pickups(nums : Array[int]):
	found_list = nums
	for i in get_child_count():
		var f = nums.find(i)
		if !(f == -1): get_child(i).queue_free()
