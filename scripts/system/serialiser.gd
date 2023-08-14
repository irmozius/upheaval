extends Node3D

var opened_doors : Array[int]

func set_doors(doors : Array[int]):
	opened_doors = Array(doors)
	for i in opened_doors:
		print(i)
		get_child(i).open_door(true)

