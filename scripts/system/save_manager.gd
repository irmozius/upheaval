extends Node

func save_data(player : PlayerCharacter, checkpoint):
	var weapons : WeaponsComponent = player.get_node("Camera3D/WeaponComponent")
	var keyring = player.get_node("KeyringComponent")
	var health = player.get_node("HealthComponent")
	var pickups = get_tree().get_first_node_in_group("pickups").found_list
	var doors = get_tree().get_first_node_in_group("doors").opened_doors
	var save := SaveData.new()
	save.empty = false
	save.arsenal = weapons.arsenal
	save.ammo = [weapons.light_ammo, weapons.med_ammo, weapons.heavy_ammo]
	save.keys = keyring.keys
	save.checkpoint = checkpoint.get_index()
	save.pickups = pickups
	save.hp = health.hp
	save.doors = doors
	ResourceSaver.save(save, "user://save.tres")

func load_data(player : PlayerCharacter):
	if !ResourceLoader.exists("user://save.tres"):
		return SaveData.new()
	
	var data : SaveData = ResourceLoader.load("user://save.tres", "SaveData", ResourceLoader.CACHE_MODE_REPLACE)
	
	return data
