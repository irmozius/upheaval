extends Node3D

@onready var weapons = $".."
@onready var proot = get_tree().get_first_node_in_group("proj")
@onready var spawn_pos = $spawn_pos

@export var wep_name := "pistol"
@export var damage := 5.0
@export var bullet_res : PackedScene
@export var rate := 0.5
@export var clip_size := 25
@export_enum("light", "medium", "heavy") var rounds := "light"

var team := ""
var can_fire := true
var clip := clip_size
var timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(cooldown)
	if get_parent() is PlayerWeapons:
		team = "player"

func cooldown():
	can_fire = true

func shoot():
	if !can_fire: return
	can_fire = false
	var bullet = bullet_res.instantiate()
	bullet.init(spawn_pos.global_position, get_dir(), team, damage)
	proot.add_child(bullet)
	timer.start(rate)
	
func get_dir():
	var cast : RayCast3D = weapons.cast
	var pos := cast.global_position
	var spot : Vector3
	if cast.is_colliding():
		spot = cast.get_collision_point()
	else:
		var fw : Vector3 = -cast.global_transform.basis.z 
		spot = pos + (fw * 300)
	var dir : Vector3 = pos.direction_to(spot)
	return dir

