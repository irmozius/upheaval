extends Node3D

var opened_doors : Array[int]

func set_doors(doors : Array[int]):
	for i in get_child_count():
		var f = doors.find(i)
		if !(f == -1): get_child(i).open_door(true)
