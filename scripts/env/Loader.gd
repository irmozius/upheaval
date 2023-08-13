extends Node

@onready var player_res = preload("res://scenes/characters/player_character.tscn")
@onready var world = $".."
@onready var start_pos = $"../start_pos"
@onready var checkpoints = $"../checkpoints"
@onready var pickups = $"../Pickups"
@onready var doors = $"../doors"

func _ready():
	var player : PlayerCharacter = player_res.instantiate()
	player.get_node("states").defer_idle = true
	world.add_child.call_deferred(player)
	await player.ready
	var data = SaveManager.load_data(player)
	if !data.empty:
		checkpoints.set_checkpoints(data.checkpoint)
		pickups.set_pickups(data.pickups)
		doors.set_doors(data.doors)
		load_game(player, data)
	else:
		start_game(player)
	
func start_game(player):
	player.global_position = start_pos.global_position
	player.get_node("states").change_state("idle")
	
func load_game(player : PlayerCharacter, data : SaveData):
	var weapons : WeaponsComponent = player.get_node("Camera3D/WeaponComponent")
	var keyring = player.get_node("KeyringComponent")
	var health = player.get_node("HealthComponent")
	var cp = checkpoints.get_child(data.checkpoint)
	var new_pos : Vector3 = cp.global_position
	var new_rot : Vector3 = cp.global_rotation_degrees
	new_pos.y += 0.3
	player.global_position = new_pos
	player.global_rotation_degrees = new_rot
	health.hp = data.hp
	health.hpbar.value = health.hp
	weapons.arsenal = data.arsenal
	weapons.light_ammo = data.ammo[0]
	weapons.med_ammo = data.ammo[1]
	weapons.heavy_ammo = data.ammo[2]
	weapons.weapon.update_ammo_display()
	keyring.keys = data.keys
	player.get_node("states").change_state("idle")
