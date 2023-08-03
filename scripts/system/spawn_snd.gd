extends AudioStreamPlayer3D

@onready var world = get_tree().get_first_node_in_group("world")

func splay():
	var s = duplicate()
	world.add_child(s)
	s.global_position = global_position
	s.play()
	await s.finished
	s.queue_free()
