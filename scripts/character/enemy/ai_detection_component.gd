class_name AI_Detection extends Node3D

@export var team := "enemy"

@onready var entity = $".."
@onready var area_3d = $Area3D
@onready var ray_cast_3d = $RayCast3D
@onready var timer = $Timer
@onready var tracker = $"../TargetTrackerComponent"

var active := true

func _ready():
	ray_cast_3d.add_exception(area_3d)
	ray_cast_3d.add_exception(entity)

func _on_timer_timeout():
	if !active: return
	var cols : Array = area_3d.get_overlapping_areas()
	for i in cols:
		if i is PlayerDetectable:
			var vis = await can_see_entity(i)
			if vis:
				tracker.set_target(i.entity)
#				tracker.target = i.entity
				active = false
				timer.stop()
				return
	timer.start()
				
func can_see_entity(det : PlayerDetectable):
	ray_cast_3d.look_at(det.global_position)
	await get_tree().physics_frame
	if ray_cast_3d.is_colliding():
		var col = ray_cast_3d.get_collider()
		return col == det
	return false
