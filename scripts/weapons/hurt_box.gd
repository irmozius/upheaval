class_name HurtBox extends Area3D

@export var active := false

var team := ""
var entity
var damage := 5.0

signal wall_hit
signal enemy_hit

func hit_wall(body):
	if body is StaticBody3D: wall_hit.emit()

func get_hits():
	var cols = get_overlapping_areas()
	for area in cols:
		if area is HitBox:
			if area.team != team:
				area.receive_hit(damage, entity)
				enemy_hit.emit(area)

func _on_area_entered(area):
	if !active: return
	if area is HitBox:
#		print('hit')
		if area.team != team:
			area.receive_hit(damage, entity)
			enemy_hit.emit(area)
