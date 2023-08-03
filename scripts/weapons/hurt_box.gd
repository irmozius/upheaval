extends Area3D

var team := ""
var entity
var damage := 5.0
var active := false

signal wall_hit
signal enemy_hit

func hit_wall(_body):
	wall_hit.emit()

func _on_area_entered(area):
	if !active: return
	if area is HitBox:
		if area.team != team:
			area.receive_hit(damage, entity)
			enemy_hit.emit(area)
