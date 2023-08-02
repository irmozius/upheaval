extends Node3D

@onready var hurt_box = $HurtBox

var active := false
var dir : Vector3
var pos : Vector3
var team : String
var damage := 5.0

func init(new_pos : Vector3, new_dir : Vector3, t: String, d: float):
	pos =  new_pos
	dir = new_dir
	team = t
	damage = d
	
func _ready():
	global_position = pos
	hurt_box.damage = damage
	$MeshInstance3D.show()
	look_at(dir, Vector3.UP)
	active = true

func _physics_process(_delta):
	if active: global_translate(dir*3)

func _on_hurt_box_wall_hit():
	queue_free.call_deferred()

func _on_timer_timeout():
	queue_free()

func _on_hurt_box_enemy_hit(_e):
	queue_free()
