class_name HurtBox extends Area3D

@export var active := false

@onready var part = $bloodpart

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
				send_hit(area, damage)
				
func _on_area_entered(area):
	if !active: return
	if area is HitBox:
#		print('hit')
		if area.team != team:
			send_hit(area, damage)

func send_hit(area : Area3D, damage: float):
	area.receive_hit(damage, entity)
	enemy_hit.emit(area)
	spawn_part(area.global_position)

func spawn_part(apos : Vector3):
	var dir := apos.direction_to(global_position)
	var dis := apos.distance_to(global_position)
	var ppos = apos + (dir * (dis * 0.8))
	var p = part.duplicate()
#	p.init(part)
	var world = get_tree().get_first_node_in_group("world")
	world.add_child(p)
	p.global_position = ppos
	p.emitting = true
	await get_tree().create_timer(2).timeout
	p.queue_free()
