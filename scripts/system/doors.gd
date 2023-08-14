extends Node3D

var opened_doors : Array[int]

func set_doors(doors : Array[int]):
	opened_doors = doors
	for i in opened_doors.size():
		get_child(opened_doors[i]).open_door(true)

