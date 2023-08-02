extends Area3D

var team := ""
var damage := 5.0

signal wall_hit
signal enemy_hit

func hit_wall(_body):
	wall_hit.emit()

func _on_area_entered(area):
	if area is HitBox:
		if area.team != team:
			area.receive_hit(damage)
			enemy_hit.emit(area)
