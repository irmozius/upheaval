class_name RotatorComponent extends Node3D

@onready var states = $"../states"
@onready var entity = $".."

func check_state() -> bool:
	var enabled := true
	if states.state.name == "death": enabled = false
	if states.state.name == "disabled": enabled = false
	return enabled
	
func face_dir(dir : Vector3):
	dir.y = global_position.y
	entity.look_at(dir)
	
func rotate_entity(rot : Vector2):
	if !check_state: return
	entity.rotate_y(rot.x/10)
	if get_cam():
		var crot_old : float = get_cam().rotation_degrees.x
		var crot_new = clamp(crot_old - (rot.y*5), -60, 60)
		get_cam().rotation_degrees.x = crot_new

func get_cam():
	return get_node("../Camera3D")
