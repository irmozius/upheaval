class_name WeaponsComponent extends Node3D

@export var team := "player"
@export var light_ammo := 300
@export var med_ammo := 200
@export var heavy_ammo := 100
@export var arsenal : Array[PackedScene] = [preload("res://scenes/weapons/bone_pistol.tscn"),
						preload("res://scenes/weapons/sinew_rifle.tscn"),
						preload("res://scenes/weapons/meat_launcher.tscn")]

@onready var entity = $"../.."
@onready var cast = $"../RayCast3D"
@onready var ammo_lab = $"../../UI/Label"

var weapon

var num := 0

func _ready():
	spawn_weapon(0)
	
func spawn_weapon(n : int):
	var w : Weapon = arsenal[n].instantiate()
	weapon = w
	weapon.team = team
	add_child(w)
	await tween_weapon_spawn(true).finished
	w.disabled = false
	
func weapon_attack(_type : String):
	weapon.shoot()

func weapon_reload():
	weapon.reload()

func tween_weapon_spawn(inward : bool):
	var to := 0.0 if inward else -1.0
	weapon.position.y = -1.0 if inward else 0.0
	var t := create_tween()
	t.tween_property(weapon, 'position:y', to, 0.15)
	return t
	
func change_weapon():
	weapon.disabled = true
	await tween_weapon_spawn(false).finished
	weapon.queue_free()
	num = wrapi(num + 1, 0, (arsenal.size()))
	spawn_weapon(num)


