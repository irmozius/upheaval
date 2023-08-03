class_name AI_Tracker extends Node3D

@onready var entity = $".."
@onready var ai_detection_component = $"../AIDetectionComponent"

var target
var target_pos : Vector3
var target_dir : Vector3
var target_dis : float
var aim_pos : Vector3

func set_target(t):
	if target: return
	target = t
#	aim_pos = t.global_position + 
	target.get_node("HealthComponent").died.connect(target_death)

func target_death():
	target = null

func _process(_delta):
	var pos : Vector3 = entity.global_position
	if target:
		target_pos = target.global_position
		aim_pos = lerp(aim_pos, target_pos, 0.6)
		target_dir = pos.direction_to(target_pos)
		target_dis = pos.distance_to(target_pos)

func _on_hit_box_component_hit(_d, entity):
	if target: return
	if !entity: return
	set_target(entity)
	ai_detection_component.timer.stop()
	ai_detection_component.active = false
