extends AudioStreamPlayer3D

@export var calc_occlusion := true

@onready var world = get_tree().get_first_node_in_group("world")
@onready var player_zs = get_tree().get_first_node_in_group("player_zs")
@onready var zs = preload("res://scenes/system/zonescan.tscn")

var area : Area3D
var zone

func _ready():
	if !calc_occlusion: return
	var a = zs.instantiate()
	add_child(a)
	a.global_position = global_position
	area = a
	
func splay():
	var s = duplicate()
	world.add_child(s)
	s.global_position = global_position
	if !zone and calc_occlusion:
		await area.found_zone
#	print(zone.name)
	s.play()
	await s.finished
	s.queue_free()

func _process(_delta):
	if !calc_occlusion: return
	zone = area.zone
	if !player_zs: return
	if player_zs == self: return
	var pz = player_zs.zone
	if zone == pz:
		bus = "Room"
	else:
		bus = "OutsideRoom"
