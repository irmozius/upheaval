extends GPUParticles3D

var part
var active := false

func init(p):
	part = p
	active = true

func _ready():
	if !active: return
	emitting = true
	await get_tree().create_timer(1.2).timeout
	emitting = false
	await get_tree().create_timer(0.8).timeout
	queue_free()
	
func _process(delta):
	if !part: return
	global_position = part.global_position
	global_rotation = part.global_rotation
