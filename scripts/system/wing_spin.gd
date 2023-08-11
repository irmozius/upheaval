extends MeshInstance3D

var speed := 0.5

@export var left := true

func _process(delta):
	rotate_y(speed if left else -speed)
