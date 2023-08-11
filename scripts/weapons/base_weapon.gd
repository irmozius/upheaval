class_name Weapon extends Node3D

@onready var weapons = $".."
@onready var proot = get_tree().get_first_node_in_group("proj")
@onready var spawn_pos = $spawn_pos
@onready var flare = $spawn_pos/flare
@onready var shot_sound = $shot_sound
@onready var reload_sound = $reload_sound
@onready var animation_player = $AnimationPlayer
@onready var reload_end_sound = $reload_end

@export var wep_name := "pistol"
@export var damage := 5.0
@export var bullet_res : PackedScene
@export var rate := 0.5
@export var reload_time := 1.0
@export var kickback := 0.2
@export var clip_size := 25
@export var mag_mesh : Node
@export var bone_part : Node
@export_enum("light", "medium", "heavy") var rounds := "light"

var clip := 25
var team := ""
var disabled := true
var can_fire := true
var timer
var lerp_back := true
var reloading := false

signal reload_mid

func _ready():
	if get_stockpile() > clip_size:
		clip = clip_size
	update_ammo_display()
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(cooldown)
	team = weapons.team

func cooldown():
	if disabled or reloading: return
	if (clip > 0) and (get_stockpile() > 0):
		can_fire = true

func shoot():
	if disabled: return
	if !can_fire: return
	can_fire = false
	recoil()
	minus_ammo()
	muzzle_flare()
	if bone_part:
		spawn_bone_part()
	var bullet = bullet_res.instantiate()
	bullet.init(spawn_pos.global_position, get_dir(), team, damage, weapons.entity)
	proot.add_child(bullet)
	timer.start(rate)
	shot_sound.splay()

func recoil():
	position.z = kickback * randf_range(0.9,1.1)
	position.x = randf_range(-0.05,0.05)
	var rot = kickback * 2
	rotation_degrees.x = randf_range(rot,rot*1.5)

func get_stockpile():
	match rounds:
		"light":
			return weapons.light_ammo
		"medium":
			return weapons.med_ammo
		"heavy":
			return weapons.heavy_ammo

func update_stockpile(amnt):
	match rounds:
		"light":
			weapons.light_ammo = amnt
		"medium":
			weapons.med_ammo = amnt
		"heavy":
			weapons.heavy_ammo = amnt

func reload():
	if clip == clip_size: return
	animation_player.play("reload")
	reload_sound.play()
	can_fire = false
	lerp_back = false
	reloading = true
	var ammo = get_stockpile()
	if ammo >= clip_size:
		clip = clip_size
	elif ammo > 0:
		clip += ammo
	elif ammo == 0:
		return
	reload_rotate()
	var t = create_tween()
	t.tween_property(self, 'position:y', 0.2, 0.3)
	await t.finished
	await get_tree().create_timer(reload_time - 0.3).timeout
	reload_end_sound.play()
	reload_mid.emit()
	lerp_back = true
	update_ammo_display()
	if mag_mesh:
		scale_mag()
	await get_tree().create_timer(0.1).timeout
	can_fire = true
	reloading = false

func reload_rotate():
	var t = create_tween()
	t.tween_property(self, 'rotation_degrees:z', randf_range(-20,-40), 0.2)
	await reload_mid
	var tt = create_tween()
	tt.tween_property(self, 'rotation_degrees:z', 0, 0.2)

func spawn_bone_part():
	var p = bone_part.duplicate()
	var world = get_tree().get_first_node_in_group("world")
	world.add_child(p)
	p.init(bone_part.global_position)
	
func minus_ammo():
	var ammo = get_stockpile()
	ammo = clamp(ammo - 1, 0, 100000)
	clip = clamp(clip - 1, 0, clip_size)
	if clip == 0:
		can_fire = false
	if ammo == 0:
		can_fire = false
	update_stockpile(ammo)
	update_ammo_display()
	if mag_mesh:
		scale_mag()
	
func _process(_delta):
	lerp_pos()
	
func lerp_pos():
	if !lerp_back: return
	if disabled: return
	position = lerp(position, Vector3.ZERO, 0.5)
	rotation_degrees.x = lerp(rotation_degrees.x,0.0,0.5)

func scale_mag():
	var new_size : float = float(clip) / float(clip_size * 0.9)
	mag_mesh.scale.y = new_size

func update_ammo_display():
	if !weapons.team == "player": return
	var lab : Label = weapons.ammo_lab
#	var ammo = get_stockpile()
	lab.text = str("Clip: %s" % clip)

func muzzle_flare():
	flare.rotate_z(randf())
	flare.pixel_size = 0.0017 * randf_range(0.8,1.2)
	flare.show()
	await get_tree().create_timer(0.1).timeout
	flare.hide()
	
func get_dir():
	var cast : RayCast3D = weapons.cast
	var pos : Vector3 = spawn_pos.global_position
	var spot : Vector3
	if cast.is_colliding():
		spot = cast.get_collision_point()
	else:
		var fw : Vector3 = -cast.global_transform.basis.z 
		spot = pos + (fw * 300)
	if team == "enemy":
		spot += Vector3(randf_range(-2,2),
						randf_range(-2,2),
						randf_range(-2,2))
	var dir : Vector3 = pos.direction_to(spot)
	return dir

