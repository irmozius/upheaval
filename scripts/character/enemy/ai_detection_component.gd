class_name AI_Detection extends Node3D

@export var team := "enemy"

@onready var entity = $".."
@onready var area_3d = $Area3D
@onready var ray_cast_3d = $RayCast3D
@onready var timer = $Timer
@onready var tracker = $"../TargetTrackerComponent"

var active := true
var detectable : PlayerDetectable
var can_see : bool

func _ready():
	ray_cast_3d.add_exception(area_3d)
	ray_cast_3d.add_exception(entity)

func _on_timer_timeout():
	if !active: return
	var cols : Array = area_3d.get_overlapping_areas()
	for i in cols:
		if i is PlayerDetectable:
			detectable = i
	timer.start()

func _process(delta):
	can_see = can_see_entity()
	if active and can_see:
		tracker.set_target(detectable.entity)
		active = false
		timer.stop()
				
func can_see_entity():
	if !detectable: return false
	ray_cast_3d.look_at(detectable.global_position, Vector3.UP)
	if ray_cast_3d.is_colliding():
		var col = ray_cast_3d.get_collider()
		if col == detectable: return true
	return false
