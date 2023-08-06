extends Node3D

@export var speed := 3.0
@onready var hurt_box = $HurtBox

var entity
var active := false
var dir : Vector3
var pos : Vector3
var team : String
var damage := 5.0

func init(new_pos : Vector3, new_dir : Vector3, t: String, d: float, e):
	entity = e
	pos =  new_pos
	dir = new_dir
	team = t
	damage = d
	
func _ready():
	hurt_box.entity = entity
	hurt_box.team = team
	hurt_box.damage = damage
	look_at(dir, Vector3.UP)
	global_position = pos
	await get_tree().process_frame
	active = true
	hurt_box.active = true
#	await get_tree().process_frame
	$MeshInstance3D.show()
	
func _process(delta):
	print(global_position)

func _physics_process(_delta):
	if active: global_translate(dir*speed)

func _on_hurt_box_wall_hit():
	queue_free.call_deferred()

func _on_timer_timeout():
	queue_free()

func _on_hurt_box_enemy_hit(_e):
	queue_free()
