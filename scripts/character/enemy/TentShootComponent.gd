extends Node3D

@onready var entity = $"../../../.."
@onready var hurt_box : HurtBox = $HurtBox
@onready var part = $spurtpart

func _ready():
	hurt_box.entity = entity
	hurt_box.team = "enemy"
	hurt_box.damage = 30.0

func shoot():
	for i in get_children():
		if i.has_method("shoot"):
			i.shoot()
	
func spawn_part():
	var p = part.duplicate()
	p.init(part)
	var world = get_tree().get_first_node_in_group("world")
	world.add_child(p)
