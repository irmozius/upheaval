extends GPUParticles3D

func init(pos):
	global_position = pos
	emitting = true
	await get_tree().create_timer(3).timeout
	queue_free()
