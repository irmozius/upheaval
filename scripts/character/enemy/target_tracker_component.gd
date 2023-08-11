class_name AI_Tracker extends Node3D

@export var danger_level := 1.0

@onready var entity = $".."
@onready var ai_detection_component = $"../AIDetectionComponent"

var target
var target_pos : Vector3
var target_dir : Vector3
var target_dis : float
var aim_pos : Vector3

func set_target(t):
	if target: return
	MusicManager.danger += danger_level
	target = t
#	aim_pos = t.global_position + 
	target.get_node("HealthComponent").died.connect(target_death)

func target_death():
	target = null

func _process(_delta):
	var pos : Vector3 = entity.global_position
	if target:
		target_pos = target.global_position
		aim_pos = lerp(aim_pos, target_pos, 0.5)
		target_dir = pos.direction_to(target_pos)
		target_dis = pos.distance_to(target_pos)

func _on_hit_box_component_hit(_d, e):
	if target: return
	if !e: return
	set_target(e)
	ai_detection_component.timer.stop()
	ai_detection_component.active = false
