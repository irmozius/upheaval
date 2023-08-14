class_name PickupGrabComponent extends Area3D

@onready var entity = $".."
@onready var weapon_component : WeaponsComponent = $"../Camera3D/WeaponComponent"
@onready var health_component : HealthComponent = $"../HealthComponent"
@onready var heal_green = $"../UI/heal_green"
@onready var keyring_component = $"../KeyringComponent"

func pickup(pickup_res : PickupResource):
	match pickup_res.r_type:
		"Key":
			keyring_component.keys.append(pickup_res.key)
		"Weapon":
			weapon_component.arsenal.append(pickup_res.weapon)
		"Health":
			health_component.change_hp(pickup_res.hp_amount)
			tween_hp_col()
		"Ammo":
			match pickup_res.ammo_type:
				"light":
					weapon_component.light_ammo += pickup_res.amount
				"medium":
					weapon_component.med_ammo += pickup_res.amount
				"heavy":
					weapon_component.heavy_ammo += pickup_res.amount

func tween_hp_col():
	heal_green.show()
	var t = create_tween()
	t.tween_property(heal_green, 'color', Color("a9ce7a00"), 1)
	await t.finished
	heal_green.hide()
