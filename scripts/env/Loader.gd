extends Node

@onready var player_res = preload("res://scenes/characters/player_character.tscn")
@onready var world = $".."
@onready var start_pos = $"../start_pos"
@onready var checkpoints = $"../checkpoints"
@onready var pickups = $"../Pickups"
@onready var doors = $"../doors"
@onready var enemies = $"../enemies"

func _ready():
	var player : PlayerCharacter = player_res.instantiate()
	player.get_node("states").defer_idle = true
	world.add_child.call_deferred(player)
	await player.ready
	fadein_fx()
	var data : SaveData = SaveManager.load_data(player)
	if !MusicManager.playing:
		MusicManager.playing = true
		MusicManager.current_song = data.current_song
		MusicManager.current_player = MusicManager.get_node(data.current_song)
		MusicManager.get_node(MusicManager.current_song).mplay()
	else:
		if !MusicManager.current_song == data.current_song:
			MusicManager.current_player.transition(MusicManager.get_node(data.current_song))
	if !data.empty:
		checkpoints.set_checkpoints(data.checkpoint_list)
		pickups.set_pickups(data.pickups)
		doors.set_doors(data.doors)
		enemies.set_killed(data.killed_enemies)
		load_game(player, data)
	else:
		start_game(player)

func fadein_fx():
	var t = create_tween()
	t.tween_method(fade_fx, -60, 0.0, 1.0)

func fade_fx(value : float):
	var bus = AudioServer.get_bus_index("Room")
	AudioServer.set_bus_volume_db(bus, value)
	
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
	keyring.keys = data.keys
	player.get_node("states").change_state("idle")
