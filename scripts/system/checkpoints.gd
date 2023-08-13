extends Node3D

func set_checkpoints(num : int):
	for i in range(num + 1):
		get_child(i).passed = true
